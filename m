Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D172C9832F
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 20:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D769540A55;
	Sat, 26 Sep 2026 20:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upUibXcn1cyY; Sat, 26 Sep 2026 20:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E56A340A29
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790453533;
	b=BbbeLbBEkCxgEDTZlFChbHl3CrsFxsp9Xj5fTJJxJ/FQwS49qxS+hbfiqsbqxMbkbLw1
	 tfkqgAkcADSQmZo+AJCE2ZIIOWg9ZMkNeHhHETsnP9wmW1G1xumgL8R40ne5zaJn2/L+2
	 SQTNTcDE5U/g6c9TLUNmBagO9LeIfrY30fHlwDq6mWdjBqdwSjNVuEaw5weB3W8ySgvNx
	 G0DXmw6BX7INT2IyHB4j9jStCbRlSUayo//NIcs8if7uYyzvEhSFJ9R1kgDL82jmv5Z9+
	 XMHhW8lwQSv0tJ9N89COJnSvCUZg+Q1lN+EOGv3PpUeFqovyWpZGPOys3UPrlszidpw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790453533;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
	b=MquISGP3aWB21ZUrbeR3wovOJYLJZWT9sVk9fJ45WIns+JfPIe4m15+EukCsQLbhh6PE
	 lQexAKKD7HuGjtTnqDrG+PqaIQlvp30cb78x7+Roaze2kcbvX8wVUXbYcM06RuY/uSNsi
	 iajhYdVoMtQ+MaRR77MPEK30LApn4OSgoCHqDabLVXpxEUzRFfjLHmNyfVQIhkb+wd2Pj
	 RHZIsUWc3o8RBjB8Jz+Im0VwYvSW0Pcjml6mRx6i7rn39+83YTC8Mq7rxbSDRfEzM7To1
	 qn2K89zrutYILS6ZIh7z8HrESkbBCFY6vIBADkBYgmoaAGLTczkWXwTArCuKsXhlSkQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790453533;
	bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/Ruy851dOIJ7ocGY6/aonEzvAkBfZxtybk7FNe6HAXJN38Sgec+kyckwcsSpg6SX
	 oemXyQRde3KM5VviELK5I2aKh+dKQhhymT5HlibNWB+Ex0eWJcPFyleFxgAq5x7Z3h
	 cqk6mb77fIOXoOEdai/tWanWjHuDjJySpQfoFhmMKyTE1iABBrwwoXBGT2KqNyYixX
	 PQcxcyz+8qaxe2blMFK9UnQVkFRK81pf94bQcrFmeUlSxNBxL8JIyLFoDuk5P9QMaK
	 t60j4S7U7WCshJobK3wwAvuy+T3pTkXQ51aQ2wjVtWPdKaR3iBF4IhqbcWa5TuAbpr
	 ZI/VA2xVIhX8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E56A340A29;
	Sat, 26 Sep 2026 20:12:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B9EF335
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E60C76065A
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1li5caIMCAz for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 20:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B398060653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790453531;
 b=jxRG7QPXjPK3G2b+srf04Ei64gD8i1mN3H7feE67jcBNgUmdf964GUjFZDYbwzddWmTD
 C0cVv8uKLpzLs9pFV9VigEsTrbC/mVAdj1IgKP/2hgDKd80LuLl33u4dYCmukDNXfo0qE
 YsRBLgReBLu4X4n7u2IP+w63Wsqeb3MZLMQmq3GQLUzYwK/cCUvaqD5jH58UxpgCF1dIX
 Mv7jvXzY+luMnG0Xo8rtVyjQeCzIVneEjbE6CV8QVrMXs+FVwkdIuaDslZ4Zfq34H3oeY
 iqHh6/Gs76TvOeX/Hhr8apHXcd8guYv5dYR9Z5wTUwJ6x9k5hbxPbb9lOzyzNNh36hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790453531;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
 b=lbewIzqUookcEqMUfGndM5Ddw6c1aS5BZq0b6MjuBKOq6/pwZbE1RcTZU5b1IxKYpCcT
 z6aHDfsyeWd/nqkRwR3/QOuTpXa6SsNCP5lC19j+ewKRfdalIoXZx56ar7xdSinrtjXYz
 z9XuUXiJI8sQxIly+zL7h2A5LdNVYEVRHWSiivUylUmQK7IGZ42LZQ4a41UtdjvG2CvYV
 ocbx43afItqYvNNASETJGW2hgWE5P1J25LbwmstsqPdD3uotg6z+IyuGHOruK2N8HoSGo
 JXB88dRbGsPyIU7ZTpGcHKOlmzcMAc9Z00j7m7Zu34CXUXNr3xyXnEtl3Wpp0cw75+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Wzvtl0Bw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::f;
 helo=mail-lr2-x0f.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Wzvtl0Bw
Received: from mail-lr2-x0f.google.com (mail-lr2-x0f.google.com
 [IPv6:2a00:1450:4864:38::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B398060653
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 20:12:10 +0000 (UTC)
Received: by mail-lr2-x0f.google.com with SMTP id
 38308e7fff4ca-3a6124046f0so15546491fa.3
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 13:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790453528; cv=none;
 d=google.com; s=arc-20260327;
 b=MBeCgzLoh7Mrmk5jUNDceCXUC9+FDByqr43kxegmb42QVkAsrw9+7QIoMhlpf5jwdS
 7OIO2baLC4PZH89DVywjxKsAYh+/dwYXdRDIYstUcPDfvH/hcqkT4duWQgRCbsyCAhbE
 NZU8IUsJmi9HmwEh1CWN2++legynhvc47JkhZgf/zF0938Wtv1QyDv1ZAoNpU8wR6t4d
 mHEd3OSMtzE70WrfcT9uc7H7kai1Z8GWP4dfqet5EzFqRqorju39BQPjrM6SllymcuH6
 O4g/1iF1Mi5csycHpNZNey7jjKaio1Jdgw02QcVF2Hsz9DvXFHyOAtUXWBi5uHcRLNxB
 FOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
 fh=lQMAua7wmDjOvAVG8TLMU8EeXQHRLUoL8Vqkf3dTunE=;
 b=FH0lui3VXsvLPLgBipq8qAymCPGlnOCI0xC+XWDrKrcI03oPCk6fRjCHCQi2buMX9+
 0S2kOK9EeMT+iCHmmjPYKlV2gjhu8PSjxWW9Y/wzKpUE+fB8gLX7KjP4WNInYl+s/BgM
 d7/SJ2k6bL2lj/sj13ZuT4XLQFsE5/Sx8g+2YeYgw51iC8ViIfQftELTiVGk+nXqnCQ/
 QRVsnOgcOsy9czobs/xYTN9vS5zaUo3QxuVq8or90ZcPK8yAdlE39/ighYUbJRll/yQD
 knlkVk5lYNqlYIsDAe8m+roIhOGxzdwOl7bCcnihrrMrgiIE/6PnH0dci0MmzqrGHkJW
 B+yA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790453528; x=1791058328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
 b=Wzvtl0BwYOEitSpWShasVx9pn0GQNT1lPrzMxXzsq8u5f+hwUopUDWFwxQiH72EdMQ
 r7fTuMplNrrGL4yVrd8LdZhwjTjUj4PGYAIwuMufEWoUTgIFr6LPpnwRHO4VsNJQVt+v
 C/WLF0TowFnBatbMayis5Nj7yRj6CvwxAXgpnKWqtz6cEmJCsOZd/QeuRridXVtkTyFO
 JjPSXCg8cKx874n40OR9ljkr8IrBl7YOSAu0sd/+XzY47q/jUHDfMbKH9oe0cQNzaP+f
 B/rDMe8W5I771rQi4ojuOou+99NC2vui0YjIr7qFhii32ysB6vlOamaRhST5tEDJvrf0
 d2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790453528; x=1791058328;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BbE93lNyQPLv8z4fDuikXpIIezwoWpA8u8KCF0GRzIc=;
 b=I1E8QFzxZYF7uUaNmWm6IeRaCGX62ZyXo2iBh9/I98oBYcTwWkogWWeRvdgS4sa7SI
 2TZgBhs9LfEnZJW6DmObiFVUH6bdMhhCPGlgGRLlD2uV76oLccW0p884066wDSg5siQj
 0iI+07e6iY3eV7g9RM3N3eaQqAPAX7qRwV84kAWcDVEG2yRqdQ8l29eH+3JF371TRxeW
 PDGfFQEfvCQDPdNLd9js6k7ABiUbnXaQ3ukE9P/dypGZ1MoERvuvj3vZG9ys0aSWC9IO
 l4bZdxlKu5NDnzfBNoAgA4LRzXIgFPde8x1J1CoUiqnouoE1Lwy5FpcUR0cSiacl8gjP
 PiUw==
X-Gm-Message-State: AFq9FYICl5BVUq+zCu43O5F2HE85fqU8uRYlSGfR16j0zuPqULR750OL
 0yS/gYp4Cljhjr9EFB4ljul3hX9n6ejCBuOnUvwJarn/+6IXoKuxqxohJfDvX7ezr2usifty7Ag
 eFdsSkycvex7XRw4uEj5jG5anXRc0Qrg=
X-Gm-Gg: AYBFou0gNJ7OhxyOhB+s2ciKmxLgLzmrSs+ayQN4IORyMHo3+UyqV0WHT9QXf0kWfgO
 yDWOYew/N7Zo8pWSAhS4BS/MEqWKRaCM104c49kqUnd7S2AxuudQ+yOPOzoV08qmTuPWE93y8e6
 vh/53SzaoERc600vb0d12AhdHJ3RnlSKgsap2aXtoxiyMYO0kzmDoGfNtvnmuSASCGBVZ9Odvat
 YmasqnrCHY7XJTBCmflx08BrrluOcQInp32vZAaJcrbML7FVWT5ifOI/bZUjNNV3yr/FBPj8z8w
 dv4r/GwW/1SYvSSZ4weIYj5cJLBalAyYuGMioiiTFlvJMa94Mh1gvHPhM8OGwiqfBkmmCnMiEiz
 bUAiIT9nxlbBUpVbvUa7dFv5vVZ8BYVdCC0AfrdQbK9GNxBAT3YNRdA==
X-Received: by 2002:a2e:be83:0:b0:3a6:48d1:8316 with SMTP id
 38308e7fff4ca-3a648d1870dmr18765301fa.11.1790453527760; Sat, 26 Sep 2026
 13:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260922052700.528451-1-hs@nabladev.com>
In-Reply-To: <20260922052700.528451-1-hs@nabladev.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 26 Sep 2026 17:11:56 -0300
X-Gm-Features: AclHuK8vLTUsivWJ02e9duRV2hwOej5vVuvFoKc8xLrz_f13JcZz3WWNanQGkqA
Message-ID: <CAOMZO5A25F+JPPPYgCSUOV27=auCbrsdHqCJ+6PVvzV9SPx-pw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] imx: deal with the RNG self test of the i.MX6 boot
 ROM
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Gaurav Jain <gaurav.jain@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, Peng Fan <peng.fan@nxp.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>, 
 Utkarsh Gupta <utkarsh.gupta@nxp.com>, Ye Li <ye.li@nxp.com>
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

Hi Heiko,

On Tue, Sep 22, 2026 at 2:27=E2=80=AFAM Heiko Schocher <hs@nabladev.com> wr=
ote:
>
> The boot ROM of a few i.MX6 revisions runs its RNG self test
> incorrectly, which leaves a HAB warning behind on every boot and says
> nothing about the state of the RNG.
>
> The first patch runs the test correctly, before anything else uses the
> RNG. The second one makes hab_status name the leftover event, so that
> the warning stops sending people looking for a fault in their own
> image.
>
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D214&view=3Dresul=
ts
> is fine.

Not really; Azure reports an error:

+ tools/buildman/buildman -o /tmp -seP mx6 -x engicam,phytec,toradex
Summary of current source for 86 boards (2 threads, 1 job per thread)
       arm:  w+   tbs2910 +   imx6dl_mamoj
+spl/u-boot-spl.bin exceeds file size limit:
+  limit:  0xefa0 bytes
+  actual: 0xf091 bytes
+  excess: 0xf1 bytes
+make[1]: *** [Makefile:2453: spl/u-boot-spl.bin] Error 1
+make[1]: *** Deleting file 'spl/u-boot-spl.bin'
+make: *** [Makefile:189: __sub-make] Error 2

https://dev.azure.com/hs0298/hs/_build/results?buildId=3D214&view=3Dlogs&j=
=3D3024cb51-9d6b-5eff-1dde-683017b794fa&t=3D58ec3b56-872b-5fc2-ee03-8e48280=
ded87

I got the same error in GitLab CI.

Please fix and resend.

Thanks
