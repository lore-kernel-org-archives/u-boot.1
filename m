Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68F606A32A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rzntswLq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YG+XW0Hi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1266C40669;
	Tue, 20 Oct 2026 17:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eXFJuRj2nJV8; Tue, 20 Oct 2026 17:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6654F40824
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515700;
	b=Ar1v7MmnQKjU1pnEW7j3f69ZfBaMCbfrxx8U9ovRFA/3h89jxWN6XvIw2nhTeurBHcRJ
	 HUMEAyWgTgKZHA+SdEq7xcVM3STF1RXwE1CLcMWwjQC6Ef2B5Gy5Y2tYUEnZP0sBGEfH+
	 XVBQ9skMioeav8lcHclcL8ZJ6gHK+ZfR2MbLYmsbHsDLsy6QbMyB4osQBFiDcLxFITpGF
	 lWTd0anSb24RkwovDllYhWNw9kHrl3tmLqDbRKu8anslNYv65Ytv/5JEgIvJB5z0g83zx
	 6BbwD3kCk9Q7WUNa/z6VWt3OReowND/VEK/xexWKUrjPne90My/dexeyc1GHwBmbNIw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
	b=nSWLOr2/dAvy3nVbQsySmIw2S/8kkZD2WvtvKS2Ic9icmzbzc2sckbLC0wv+pcIDbKFD
	 dpEZJ0DS/NPleKrzKlBMypGJPNMMmx/CnavfoBlZeCd5B3SPf26iZ0HDoK1ay/3pY7BEa
	 56DRiaE5FhVxWcl8eDwaL34J2pAAq6cX0b6xC4A5Af0fZmYVR45UWHUMVWGjivPTEqN6P
	 9sL29B3fNtzyo6lns0PfprQRwxW3q3pI39hoAH8uVMiJQshCZbxZXT0AxvR2pCYElJUkm
	 dBnhMevL362+eBy3GCM+EjdOaShP9+m11T+lg0Tkmpada5rQy+wX0ohtE9IdVdnO85g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515700;
	bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rzntswLqMznUL9ti7gk8Gbd6MHEWNNqn2FqAF2HJ/FWXnBwIKmgC4PZgfrqZTnKZD
	 NaYDOKQfc5y/Io8WNzixc4gbYDZfe6JG1QXdO4GAqYGVGOjIZ513sHIfaKPtHrqk3T
	 p0VzoQuCtKUmfe8vJGUPobnHkfBXJizSJGMD8AUYNVspLdjQd9pjPhZ4S6/tjLf5q4
	 kqA0zBb39UpUzOhZWptezm5mrh0MUnCL7IMHO46EzoM8xK0RXed0h0Ij8qidc6p5Xv
	 6fvYlMXdyO6MGX+BF6ocv81h2WGRc16Hv7CvdvtCaEhLm9qETufqrlgWlw0JkVj7Qa
	 WGmRXfTA4/TmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6654F40824;
	Tue, 20 Oct 2026 17:01:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D74AE3A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCF976078A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:01:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eINgfTB1oGKs for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7B8960773
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515698;
 b=RgUERcsle6DTFNIWvUrJVOa9eUmbN6ffImsNIdxtz7F5Y+KMqYZwMg+9D0mAOqzhzDsr
 KfKCwQtqCxuZPk8ibfIK2hWXkNBnr2ROWB8NGPD+eGky9dLZMQtTTijiDSnc/ftU3Ne4E
 m8JRnGg6QTJi0Aw9HtjzZJK9BOdQusnXvY6W2n1/BoQIUa7qrxYyDwNh0eXJaBFqGZm9S
 5i/u9rmScMp0g+5J9trWkh7ibc9SBIfTi3JKMkPn74Kxmt/6cNkRxJY6VXdoI4rd6Zhw0
 IX+TiyWgdDVHpznEFZZYDDqaO5cQOxWACQUAn61q62XVuUYanTB0WO6EPIFDeipuXfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
 b=hqS2ut74QvRzVpyDAfav7T/v/wjPCunjkQJsDoe2T3xRfzKTRs2wzhD4XV2FmnM22YcY
 E8qN0GQAG7ZbOVGi1ca9xZy+IBUWMDLjYUcLsjczldfjZ9ZtZZIQUwiSJ6dAaJLkOzDvj
 GILELrWdb6rjAko8Yx5aWn534xKTuMpm1xtdA+5ikM+pSIipVnf508z8fWtmzI9uLOGxY
 5QMC1Oz57hAy9zy4FxNpjLvakPYc+XEzVt8fJzL2RRJ0wxVEmYoISNPwCjsy0t4mawb14
 afNbrw7z8MKm1zdq9QW79Cp5f/5lNZ6AWWjaWyT4LlOi1P8ig//fvkBWKYi7bqaflZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YG+XW0Hi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YG+XW0Hi
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7B8960773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:01:37 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5bcb6faf862so3179804e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515695; cv=none;
 d=google.com; s=arc-20260327;
 b=FjtHkXS3tPOOlNWfYZH+1xvNQUAYZ1dyr3v2kleQxSotx5kh+xnvqGvrvblTJSzLDw
 iaKjvxUvQTp0fS20knS8kZdgb2z19601cFVclEd+oYdb3vRvtsVwEmf9CUXd2efjeEmM
 VMCw950STDSl9jgOGrV+eauzkXjvPD9X7a0/fOmNUQZZRpMf3os00q5bi8UXERFIwL6w
 9CF0FBFEOHnUG9s0MeOLR4BLdAba1QOtCe6BvZAmHk3tAp15F3aM47HBQHaQGN1BA8uY
 v42H60Pk6EkJlbqPQLwRPsfCJePAWCs5y8gRo6Q8R14Or5lktJEuN8iAfaB32/AZwQz1
 C5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
 fh=MxZOMOniZFW4tWC2eXFSqapIP5MZf07Y0AIUaB5Ll/w=;
 b=LK6UT2UfrZXGFmKRYFxSmkYT17DFTcYNW31MINAOFqgEgFvpTF1XuOu2Ch7/Mx6UzX
 71ECLbAyhqIQR/MZtoeasJ9nHr5s8BON4JLtu0DmEBaFs3nnTSk4TzYJGvbF/HrclgPR
 NhOgbb/nTsZQnI+CDv54V/Zz/yJVO4DrtpAg2qobu3EWh6CT3sJoeCFEnFFdeytV86xC
 K0/kus1M4LDvSmnCEI8BWeke7R59dNPYq9VtLkG2rLaeEMVdC5LDg+MjaYJxDdfqpKBe
 wvUFqM+/weXiavjGnsN3Qtrj6NXzlfpNazk90rgZzK8erPDF03+OB1q0b0ajtJEAYFjt
 6beQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792515695; x=1793120495;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
 b=YG+XW0HikfD86cnSPcfT3EDmuokA9oQ2SeadGOCMy0h/Q6YmePTrMmyUoYi3/bVDJM
 Vy3PdC+SFjuqeYj+1CzGBGXBdNIZ7Da5p9KEZ96R02A+CQaII4NWyh6Y1zixx/dkAKGL
 jD3tk4wcrK5XZQkbrQ/XC05MIW2O2GgUi+js7udV0Qg2ZkDbBaiUuls+JkQcTIZexMOM
 Y2AxvMMJvw5wdJpOynVuTylKwE5+SMPCwjpBBwG0svYyVe7Gv/RhjVL4Z8fQDn4qqvsx
 /BDsbI3oRL3tZc3AK+A8yLFML1XpgQo+mzt+VJsfv0G4aZHmCeA/ECP90MAbSbApPYT+
 3HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515695; x=1793120495;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Gr5otFzz4zmtQhlEJA50BShrWj2kLwwWm/8pZmyfCo=;
 b=vY6CSpJRcpo0/sjkwsxOznp9iRI3bQIjdAnGgEmCd2uwbtS5+Vx+UYfVt2ZqwHYdin
 P7b2bh7aMB/dMJscm56q73orzQwujvWfk013p7y2BCkVWTApkAzSauqxLHD98nVYiHN3
 Xz1IhMMaeFNtLvYXCB/BCR0rlIwQeEYPc92kx3IP70C867437Yf5Jvfy38F+N3gSXEvi
 837dOzeYj39nFuBvXxrvaNTTEdBW/MBnv8vmlNlvsrJjUJuxIrkzbCRvHhSaAXPMoRbN
 ZnAWriuCWQWMTn7VGPrCTUkoTI0kCJ9v/4Y5ciZjFmpHljqSHS+3FDmqG4lkHNE19Y9s
 twGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzAB+cbp7nKfhheNnkVjw7qA5RFF6TyboudKES1YwrGAs6Lv929ofTLGtxrJemZ04dCgE6Yag=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIFJuPuy4pRMNAKzhzZKjvGgkX3EQJvBCjvBCyGY+5KkSX5ljxV
 izSX1oSKTjLAlIB+n5QnP3P31a2Q0S1+qaGf1T9VAjr9C46CCwluyCAx61Ns1rjlSOvPydfIidu
 h/mHol8kJIpm+CGEkJa0U0nAYAYp/q8su6w==
X-Gm-Gg: AYBFou1f891TSPtG1/mcBenf4N5ZEfh8DNO0YKuIQliNsf6VQNPVmXeAfF84rs9NV+k
 eTmC93z2MEXpbkz4vcM9G9N1MpTv/n/llUWBkQwF54KEk07YSN2qHvRNXHPpBw0Z4ueiXiUELqa
 8b4XAFt/HzNrhkX/kRu0R+21MG+wFAqP0srOq3jJ/WMujL33ZEkdS9eqCOcJm6nXbZCBk1pe+A1
 XLxRLbpF9cP0kphEY2Jdx3/sePKdZwMaZ0qG/daFu5/qmbr6RuSX+fGRBAS3zcXp4zgU5SEn5SC
 Wtn8NwcJ2oIO2xM+eGGbWIuLNIJVnK8GGCNteVrPS/mjpZs3goVcJQOFPZopICqMPNvNjVSXG+X
 HGd4cLHd76OVgDcQj3AYEcOrWiYs49zKVGrNZMzhNQYVrruSco8hNPZg=
X-Received: by 2002:a05:6512:668d:10b0:5be:5184:8c10 with SMTP id
 2adb3069b0e04-5be5184a6fdmr2103341e87.22.1792515694620; Tue, 20 Oct 2026
 10:01:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020063714.694164-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20261020063714.694164-1-alexander.stein@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 Oct 2026 14:01:23 -0300
X-Gm-Features: AclHuK_epyi-lhQrN4R0W27RLtto9L-hwnpiFSxt93HhrX_Bzt2X1v-VjHMtA2U
Message-ID: <CAOMZO5AbCFF4vhZH==6n4Y_YGZ+tDU0OXzVx+3XpsjHb2_1Ofw@mail.gmail.com>
Subject: Re: [PATCH 1/1] imx9: native: Add missing UART clocks
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 3:37=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:

> +
> +       /* 24M */

Please remove this line of comment. It is not helpful.

> +       ccm_lpcg_on(gate, false);
> +       ccm_clk_root_cfg(index, OSC_24M_CLK, 1);
> +       ccm_lpcg_on(gate, true);
>  }
>
