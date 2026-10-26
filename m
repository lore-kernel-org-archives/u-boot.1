Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC15606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DJPRkjiP;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iaMWcu6x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F390680CF1;
	Mon, 26 Oct 2026 21:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPvh19TNnvzE; Mon, 26 Oct 2026 21:15:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 20C4A80CE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793049307;
	b=RpxuzsQfB2OjVmigUxRb1vQ/cSzz3zSZNas9zg1rqxe4VS0zA66BGgWF//jViVPF58Hq
	 F51VS2Fio0fU6sW4qoT8+bvBMNe03SsDbZPhjk09RPT4R5goiitwNyJOsZfEzMoM/fC1M
	 mWVWCENQWxOVl8kH/FGImqeITi4UhFw6+JC8mxBzvMaKtbbziEUTF+xnIQcGnmZqzFnsC
	 TVoxc3w6ERL/p9bdsX26FSoz7cmQph0hkis+oEMukeaFuKrapoBVXDZK2v+TpCu9saB4e
	 t1tk9SVWq1ho5UUs9+8sR1mgX6wxZQhLzKgtnGLd/HE8q7TYpHTiCIN4vaWIhheZOJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793049307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u0DegL3X6k1/7D2T2KHrphD/Ef6XkefLcMyBQsj7xPM=;
	b=o9qLobSmPZ8GGxX/7XRcROV0AabI6jgYsm5ptwOO4EA0KzPTkUnwI+ilMDTiIjPVfPlb
	 Iarf6UQ/HYN0HewCy9VjXAH48wBKELqnycOLFX6wTw3DLCMwuP3nnhv0ImuZO7bIZXNeP
	 E0qWgAppRWWuViFGFhjSLpt2Ryl8Zm4we+YHvrV/lcpPxVArmRK9bScTu1NWJ9Kn2Zx4N
	 qJu3la45EliPBBTcY8buRF3wIJMpr1Vwg72cj0RXcuVd6BSfRNq5aDT4MRcOlC6vKbBwa
	 RYWtIO0Dw9sxNLCP+1Gz1Ypvs1izGAsayasv/5D8KLSM60DslyaGwcB6Bt9dmIRxQLg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iaMWcu6x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793049307;
	bh=u0DegL3X6k1/7D2T2KHrphD/Ef6XkefLcMyBQsj7xPM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DJPRkjiP2K62BrqTjkw7aZBqlu0H4YSsgN9tXtBAWAw8cKgWcLpAZbaCTWm3s3dSo
	 Ro+i1F7i1IwRpewTJQahGlztIUQkrNiTHymXg182F/lY/eF1b8CNtzkaoB/QxU70Yj
	 Mqy4KEQPYSY8SF+65/S88Y2O4vNxCvfOpMlxxP+u4TLPthSlAzhu6DwIheRJjndyeg
	 fkG9BqvEymKK6MWA7/ffxkNZtVebp5Vf2YPbsHX5JFWGBA7WNEVnK4hLccM/b+g3dg
	 x2ASRqcGIo40qOTz4HMe5YqK+pJbqbrxSLeskOgAW9I6FRUlCPgA8j2rHJ/dpg75fi
	 2Njq1+/B9fMNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20C4A80CE0;
	Mon, 26 Oct 2026 21:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 555D22F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B41780CD3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iWrF5jLYB1jp for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 21:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66E4B80CBA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793049305;
 b=AsmxcEm1BTudGEYb3eRhNNTbycKTZAamSHH06mlU/17lY0k7nOWhkGZawoIq6zBuFGDY
 XRHww7uWk9wS5Dh5uhoIcRVCepRtwEksb8g20WDoUnOmFeBDXH0L02VB4IYffRC4oXk2U
 4Av4ObaGuvkpXcKIjTI8lRYF0bX39yghRwU5uDbXAZ6WD8QYIxDJrER3w2djXKoyPG/bS
 ieFP26s5Ce0/2PJJuSrXusRn2XpuK3xofz5ZXkqX60WqC4dX5kYl1cgY8tWWaeshCM6kq
 AmP4hsAJoXhWKExPOB9Tgmf8XsPxtfzdeYtUiITg2xgOGkQbc6GwoBoptBYQMYcq6/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793049305;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=u0DegL3X6k1/7D2T2KHrphD/Ef6XkefLcMyBQsj7xPM=;
 b=REIYnVNhB4W0gLn49I3gdXVXUdjzK/nWZ4gy2aosazHs6qSoVv0vfMF78JMCiWjOOIOK
 bO+1VUMd2KBm+hSjUPapiWvyLdolmFWgMAvcABZSxNBRMAyvihIE1F7l0WmaT75fFlpKc
 MNV8xYddeCTFNtNtYbMjf1cuAJaS1W1ZPI+hxYCA09HZ5UhdcSNyCU+IR0CEZKDhUTfKu
 xUXnN7fQbJAL+p2B4LM0fWpw09h9EeK7kcScxeIQ1/fx77+zp0JCmKkTw9lzrx8eX1AAa
 Rn3coi9BESwj3/JH2HiBYpJtkims7H6pUknRMgalJYkJjLkwfeshirIFq4pfMe6Dedw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iaMWcu6x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::2;
 helo=mail-oo2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iaMWcu6x
Received: from mail-oo2-x02.google.com (mail-oo2-x02.google.com
 [IPv6:2607:f8b0:4864:31::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66E4B80CBA
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 21:15:04 +0000 (UTC)
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-824f3901d55so3939185a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793049304; x=1793654104;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0DegL3X6k1/7D2T2KHrphD/Ef6XkefLcMyBQsj7xPM=;
 b=iaMWcu6xEO6xBui03VbE2E5fb+l2s6Iejmkmk913MDoWwzRcaCubjMrpKYpxuvZTAq
 ifxx0D58WtNzrkVMbzvPUSINLAhamO7tE+fGIHRHf2hxLfNanTHgBvubTQA1ZCfW0fhJ
 xvIEGnaeLIC0IfnNI2EkEyJeDVINrJuWRAHpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793049304; x=1793654104;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u0DegL3X6k1/7D2T2KHrphD/Ef6XkefLcMyBQsj7xPM=;
 b=KYFImhdk6NujX0I440+lnLXEUPkxCgSh9oaUhkregXQPCp5MXqPcMBewWVX4RTyWrB
 Y62M30zwc0T1YoCWtRQMFV6wd2XzborJ2jW7nZzdqmk4BMBa8OPxuRPTeCk+HXAbhl5C
 U+bSVS6lPtyHFQnmqXynTwgIiNi2/Kmp1ldEoWRqjC4uaeW/JlhleJyLT6aWkfXxMap4
 HfaLLrqo3XqR9OJY8uX8Ts6G+MJ0WLkNF5XBCgYp/vp/rZP74IGICzyH5SkXrUxGHCU+
 iv9iVZ/CN1h4bdQRGqvdmvxPQoAdtLZCuLOpWU7eMq6XmOXW5lqS2orIVpvVqmxNvUpW
 3xiA==
X-Gm-Message-State: AFq9FYL7/J+nvRv3lpQa62Y9jOwm/JTx+vbnW34rhr1nJkJQkJ+9I9xi
 F3nqWX6y1Kc6FyO2jGmzIyuGhFN155pYCrWsJmwc5NLsJNIVaiNBXAu0Yc02kM9xZzcxyFqMgqz
 ZDuoAka5bAhU2xnc=
X-Gm-Gg: AYBFou0+AORsSPDIFLpmZem5Gy5YedqD2N58qpm3z+bA9OY3bcyi0gh0koCVwqS4lt7
 ZVTOhRBkXEwyrvZ4WjSdMaRiCxv7OYTC5QiyDOEbk9bg7cIG4Ej9QeeyiKnKnM6GsipwLUrb8n0
 vLgtEbf6m9sHYMC8s67m+EDEQz/MtFoOf3ri9kmg5uOsCUU+XiuT6axEcd4SBblSkikw+6h1k1J
 l49awSbZOlJongyPPxImDyVgOYigmX7l81cHA22mGkg+hQcYoH+75vZtquqXWVzGvVwlkqnxJmR
 DLqv+nYXaWl/lPu5VMp8h/3vnUcrRZGS/xU6CKVAnQCUAXcTC96B+rBRMfmLRZXj3YNqgkYqdca
 gEmKOeBBnxK6sUu2pEfPVGmd4yc6KpQsKl8XjVR7v2W/ExIxhf+MFe6X3YK1rLXFqhECCUAGtmp
 b6ifgh4lVjGuMYL9ztF0zKQYZvpiNFhW8ptoKZuyGjrQ9IQEHUee9cJUyJ9xuiyNZdlbFyJUpNy
 cHi6DkeZDsZf1vacf+99VntkRnzNovOa9IlFe42JF0X0Bs0UY80yXsnKz3ZhQRhoFfPqi1NLOK3
 bugsI+0Ehq9Y6V9g7k6J05SWZ3ygui9vs8Nsn3+glX6KizxbLoSaMSF5LuMrO/9FE5dRrH7U4ny
 SKGDPBg5E9efPB4vof0PCbbKi8zyTE5HT5vOFUmwCyQoqbsZVs7Z4QXSq
X-Received: by 2002:a05:6808:1b0f:b0:4fb:ac9b:b07f with SMTP id
 5614622812f47-55c003891c1mr4657797b6e.49.1793049303874; 
 Mon, 26 Oct 2026 14:15:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c042de7b0sm6066649b6e.13.2026.10.26.14.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:15:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bin.meng@processmission.com, 
 francesco.dolcini@toradex.com, frieder.schrempf@kontron.de, 
 qijian.guo@nxp.com, Markus.Niebel@ew.tq-group.com, 
 mehmet.fide@screeningeagle.com, rnunez@baylibre.com, 
 stefan.eichenberger@toradex.com, ye.li@nxp.com
In-Reply-To: <20261026190449.1771759-1-festevam@gmail.com>
References: <20261026190449.1771759-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20261026
Message-Id: <179304930260.718017.6666309930346067989.b4-ty@konsulko.com>
Date: Mon, 26 Oct 2026 15:15:02 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 16:04:49 -0300, Fabio Estevam wrote:

> The following changes since commit 8649a54d301a4d0ac526324c7a7ad2574939ff27:
> 
>   mtd: spinand: winbond: Clarify factory BBM offset in OOB layout (2026-10-24 08:24:15 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261026
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


