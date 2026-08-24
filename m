Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE6CC5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 23:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C9A7606AE;
	Mon, 24 Aug 2026 23:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bux1qa906nU; Mon, 24 Aug 2026 23:28:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787614130;
	bh=iARwFzOhzAezmh9lo90GSbjlMwNFVVzycR4ya19HVnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qmefha/wzZkJUlThlSFx1lwXyPudwFky21P3P+BIRcE3CsTFKfkxfxIO8WXff46BO
	 vj+sjs3spr8k/vAopJDsrmhFeGLgaoIn944Btd82XwNKhQGHOhbNg7BXxvVKbP4ogL
	 Pj+8Wc62Oj0iHNXttS83bGxZq70wrcMOi3Pn1YRyljR5e4qK4nrribRQtDDKV/RrYz
	 Jkgpc0+fIu96Iv/9vM7w1sGcQ9Z8tJuLzGGfZI7DU6EPP6qjb96dKHHMDJ0OZfSqPn
	 5+oF/UMCmeXZhbgRoQkJy1FV7F+zHztDYrI52CG0662YZ95HZih0XuGVGLFVaHbQny
	 LhvY96TXLIA9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70E0460667;
	Mon, 24 Aug 2026 23:28:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 36830279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E3F860667
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5IRrEc74YBA for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 23:28:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::132; helo=mail-lf1-x132.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=blI+IOZ7
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3B906063A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:28:46 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5b015b2d792so3925863e87.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787614124; cv=none;
 d=google.com; s=arc-20260327;
 b=alPQyXB0jf8jVzJISbmVx1SsrlvQkRPV8P2mZ4r+QYe98ZZu+3vp8/rFA11c9PZezn
 TkgiPT94KD4Xx0QLoD6wL4gRuUwsVW+4snJvL4oAbwxl6XSq8+PBbFQR8d2zFgzuR8vQ
 Py0mMF9R9NvFJEWMeVp088+RaM1RMVObif/BSeGP/X5BdvnH/b6+uF2J4Ws34zcCD64+
 yDBNsa8twEdKmn1e6i/01PaIXOF663vGiRPkV6rojGlFEhW5wMiRp7wJkNvH+1WMgHib
 EJ4Hhr/uV6acdZ2RX7q3LHWzijkWoPNjU5jurDPySlzBvt8+Q39LAFoHWL4uQHLdV9tO
 LCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iARwFzOhzAezmh9lo90GSbjlMwNFVVzycR4ya19HVnE=;
 fh=Yopv/yCDbKJlCnLh+hasEJfxXLKPiMtin7Tt06enMR0=;
 b=NTiZdlChcxjCW3m69iz/uaOQM35VTXOgvYtzxUgd71iyLr4Afy0ItDdEvcjtXYJh4R
 bAnwVwAbW0lHPucQz4giV+zteJQMmordDxmImgpkRMjP5wEg9bh+5bzfuz7n6ddoWFxf
 nMWpq97CiyqKxZBecttgzqJHYws89ENev8XYD8RBbSi5ScOk1i3TcQP9hbP7g6BZRxrL
 +qb8cru2/EArdXNulUNZdsp54/n6A8qTnB8fjYFGbhim/ixZuhepRs/BxC0YoZCunn2q
 YPuFRq2mackCZMZOp4xLCapki5/4tVKRNvZt6k0RRq3AFCkAsZ7i2FHNvaIdek2fYg0Q
 y/fA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787614124; x=1788218924;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iARwFzOhzAezmh9lo90GSbjlMwNFVVzycR4ya19HVnE=;
 b=blI+IOZ7jLNBGyA55w0MIYzGV6huII2Qyiinsng0FtM2fd0YxQtCldVDeIP2/wn/K0
 TLC/AkCooOCHYGcdaqyuoDSLrvpWmVqr5t7QWizVEAXjk1aDz/EKjjcRpVfiWhtgpkXk
 Z+k0zulZKa5/vkr1IRev++uUQjaQrXFEhG2oIfj2YNWRzSxIYL6ZutOhMsYuDZJC/Y+M
 Ri/zlrUw8pY9qf5tGZ8j4WXkGJIrhS/V/1Q+E4lB5jY16/vCnRQT9KCLqWoUssLDLChs
 trxFn4lkSrmaEqtmcPxhroxmuTo6fQ0awzhdfWyPjYndIxm3Xj4Z8jr8bU5v0fEBrznd
 JYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787614124; x=1788218924;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iARwFzOhzAezmh9lo90GSbjlMwNFVVzycR4ya19HVnE=;
 b=NMMaXHcXPp1DLCR4ogD65NdH1nHEc+zBXZzA5DMg21+XXS/spQX0eTUB7UEc1VyU1r
 ebUXyS1ktrX3NYlezFGcHZoy+YgQFRrfATnv1neXFpCy3A/rr6bfBG0Ya8bEDuy1T5SR
 +aQ5AjCw+zIf+b/Fs4qQsQz/2oB5JNdgqTj2lpKbrytqB3kw0mtgpTOtcN6WX13yfmMS
 XaTKo6ch/9Aaq/ezFrNZI7u5i5Kojl9LWAUtRnXibXAtY3WFreyPrupqgwtcGX87QdGe
 R5BRGb5+VhVkphjcOEowonlVmc2aCEBINxuJMYATE3DZxmJkdlbGjM7/hAXnxYTtNlPV
 A1sA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJdnwYM7Q2R791Mk36uJ+y9xMAMRfywlxNYT+Mzr+k610JYMZkc0QcrYrsL/eu0s1aDWIuFrw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nCgCNPm2tEXl4njnwqYyMp/UAuPTMDv8zLxfhyf7R5Hu3XzpM7
 sEt3pa9dw++rlRakOg+AGyMSucyEVNOGweUfPYh/i0CBbCF1izVM/g9DT8akV4r2GG6byzwpkjm
 kvvWMOVowzKSlAIKuvofFGarvf2Tera8=
X-Gm-Gg: AR+sD13tTpHyDVPAhEZwG22oIHqcWnOLZMIzAJ0tIqe0aHZxCdxM+DVDoNhS1I7Rege
 WIKEcSvGCZqfRIvXP8B/cjBcpQbOsYUyvoBNpuxYfLknBS49voULddezxyQb/s4P51Dg+m/K3eC
 X8Hvet3W6d3VoDSdJ/IdUGQH3THRcNxjiGNhlv+IrVXH3xhl+rM03hgHSm7mX4hDv1JHwiGxg0c
 FazqKRKA7PZy1DEJ64D3UXc9JW8GZ0sObw/371UAoaD9NKe7I+1VsMadNjjh1ysgovzxqtUg5/k
 +M6Em564fBXQn2qEY5ZZU63v5CX1JwfLJ5k6vMv4dq/wTBXeOf0WPSMPtyq7zY93pb+Zia1NhuI
 3t7P+4T7gTlkAuTRdG3K7slNNvxlzWMDa
X-Received: by 2002:a05:6512:a34e:b0:5b1:59ec:2452 with SMTP id
 2adb3069b0e04-5b48421b64cmr5839808e87.9.1787614123724; Mon, 24 Aug 2026
 16:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
 <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
 <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
In-Reply-To: <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Aug 2026 20:28:32 -0300
X-Gm-Features: AcwNN1VltiK4WTno5DTzjVE6lWRf_3QRFcY_FuanxH3yZOY3_JUTPOcCk8oLlbo
Message-ID: <CAOMZO5CbpA0cmFVsSXuGQcYQ7azRXK6XKNYgM4s5b4shGoD7sA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-imx@nxp.com, 
 Simona Toaca <simona.toaca@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Aug 20, 2026 at 11:25=E2=80=AFPM Marek Vasut <marex@nabladev.com> w=
rote:

> Why ? Init the bus in slowest mode with widest bus settings, then try
> MRRD on all available DRAM chips, then figure out which ones report
> valid IDs and which ones fail the MRd .
>
> >, so I'm not sure if there is
> > any benefit.
>
> Generic solution that surely works and does not guess the DRAM size.
>
> > Also I'm not seeing anyone doing this kind of thing. It
> > might be worth looking at, but my primary goal now is to land patch 1 o=
f
> > this series in order to fix the regression.
>
> What regression ? (I was not CCed on that)

I think Frieder refers to the regression below (patch 1/4 of the series):

https://patchwork.ozlabs.org/project/uboot/patch/20260819070758.51350-1-fri=
eder@fris.de/

> You can (=3Dshould) send bugfixes separately.

I agree.

Frieder, please submit bug fixes targeted at the 'main' branch and
cleanup/improvements targeted at the 'next 'branch.
