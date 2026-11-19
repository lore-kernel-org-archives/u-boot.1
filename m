Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA5606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t3p009zm;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LgvVRo9k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8B18815C1;
	Thu, 19 Nov 2026 22:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdqcZvHvH6zW; Thu, 19 Nov 2026 22:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21651815C3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795127209;
	b=m3Gt2oxMwwJIsYk0+AO99N+l8sDp0hK7wHrZycAT5vvbw0NyU3kOitmvDNfEIkgTm93U
	 yLlnLfazflruy5cvkd/7Be3HWRILCAE/laslcsUrNT3h1z0Lq0uvu3mvflSWaEWiYnSTq
	 2ykGQWnliYcpxL4AUy1SNbMk0qNGvQCz+tmBw+505CXsTQxXl3g+L9uxjp46lSsVSoSDt
	 d3qQUn+5Yet+OHn1wZtVdUnsptwUAmRpMIbaDNQgC/1zNSnzLooAzTcXw3ACcPInTGUo2
	 0xFo26OQuGoIF0Io3QicnnFGlkZa4Ij/IJv+3RQ+poXgB792lev8hDEct0tIA0SL9RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795127209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SoItqXT7Pjo3SKuq/x4/41qzovzPBtn1h+ENWc56Sfg=;
	b=OoJw6QxBdRRC+VyGiBCoMCPqJjFr324uqyP6klPLscWT6GY+a3Ten7lbkoG8lg/6a6/m
	 u598HoI2QecK6tJNTJf2wkYutWULAhRaqlvmB65n2EkTNkr5WuZUlAemuWS5PYQ31h30K
	 tcyzgt3S9/D3EHa7X65Ay3s3BLTgjo/Ri/Gn2vhQTgep7WIwBcJieCNzcVmzJqLHBuQMR
	 moltqADiK6w9768nO14R233vjlD42mbmvBg+PEo8Bb0Ys1/CSFgwDJrecwemCccQd4Ym5
	 ZUTUvzUzycZzfzJQgSO3J6zZF1kZUCRKd0wlEB4yeZibHwJq/ftTQm8WQrKsc4LWODw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795127209;
	bh=SoItqXT7Pjo3SKuq/x4/41qzovzPBtn1h+ENWc56Sfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3p009zmy0Q8znG11QcDSzUhQQQAq+VX8oO76IQKLdzOcVUArQdxEaSEfoPUFraum
	 fadZ25DXdry/zWNc82SyHZPHuV3exbbarYVe/yO3sKHmiElMWnMHbjryki8t0HQnZY
	 Nop7ByoIB8UktXZHcIroOZ8+dFfAkNOrSAU7wVez3fnzXavpypFHFOggHgJ3TrOORD
	 CfMSFi1iguToPe1HN9tUNnVTqyFAZ7nyDMxNgyAifLm23pAxI13CYPO7xuhLzb0sOM
	 ysMVKGM4eJVXR6y2/C4NTt8KCws0OigLHvm8P/0qRIDAACLkn5xKL5hCMuILsM+tD5
	 Ng52+5B0nTvKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21651815C3;
	Thu, 19 Nov 2026 22:26:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 183F21E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A30840185
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-uW-zYriSpV for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 22:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4F44640079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=LgvVRo9k
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4F44640079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 22:26:41 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-85ac281604dso116326a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795127201; x=1795732001;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SoItqXT7Pjo3SKuq/x4/41qzovzPBtn1h+ENWc56Sfg=;
 b=LgvVRo9kNqcZK5BQusTfhtFuacfHwLs+jcaH1o1h5/r+7lIGaS9RH4q46VQ4QQxpS+
 4q9Y8Ho+3Mtez91YBDcrCaTo2n5joP/tL7q6d3DsJbDBfwhJklQ2a8X38IDbx3cnlM/X
 GI/8PRLHkRyktd9SPKF0mneObgW4MJmi57g1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795127201; x=1795732001;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SoItqXT7Pjo3SKuq/x4/41qzovzPBtn1h+ENWc56Sfg=;
 b=DnA6FDwFw9feImUw7sbif65w9wkfiL1wt8o8EVDRje/R2TZeaxMLd2bdL/AgGIYe0y
 2LB2omu8czrQB+AQX2Lr8km1UPnt9YL2T/yjEEkgpw3OVoGeLjTZuYOiH2SliA6Aed1M
 kt97lvO1ktkoR1WwhcyxRf3fIRbSbDA8qux+Po72/BFKCvDENALE5fE3wWalJwzcsWbr
 zRpppHeUnmwMXnq/RZuqzAeJHRCw/WrgIsd2w6mxdI5JmBpNTBs2fe07hBqSAygiTaTZ
 YhSH+t1bif3vUXflJ2gLmQK2SFtozbPIeFxuKMoh+5u0ZuxXJ/upxPVbjG+2V48qsHTg
 vJ9A==
X-Gm-Message-State: APuU4Z/QeLjCVB2+ozpARiJlCiXRBqGhzpX7tjOmNW9z3Fg+GAFuJdga
 Yr5MeA78PJ3ymHjHY6RBMmaEhdFp2Tt/Gu6HEwirhaS9DiSt1cwTm7Lf61HDqFf11USJRd7OxA+
 Q2ri/XMzPmQ==
X-Gm-Gg: AYBFou2t26p2qWP/13WOmKu/nRbOi4OnhbZ2rXinPJinAW9zvvkXvS2ucToBYcjK06x
 PMztOiuuegLaBSCkV7WZq/auMaiaeeNbsH0vCpjSyvFs8CGrlyH2ZmitVysVxMygBEtt1R+5yUY
 lpQDwM5qXQFX1QTulLemBUqdQX2VQ7Ge+mGvNIoUwPRY6LAmpoyWOQD9Sb7CPCl05XPXs5pkL4K
 WBX0GxYlxKvW3I2FKLsb80YzeRaBaVj3VJKwHYyG4Dc/rLdGbBzRhRL4fTLNOtje2GFKb8sUfRw
 +BeReqfU3Kc8Sp5LeykEKBmaItiS9M/fd2DpynEdHLMxQ3LiB6fp/GN2dUCkrFoiO00MpPaxqUG
 s3FlpPt37nzhmfQTdewqMPpLuYnDdxcd4LE7OFseNMGbI4k5KdfoV1LbJqdztMuTObVkuru/hF7
 XBG8plul2tg2QdGUZAbDHydfBdzRJBTatad++otedHOKtR8JltVmxzgZnOLC7LjV6ddOxcIEPuO
 fugBdmgfWs9h6BuTKs2ONpyEBKSI5xL2Q+anBcxCkMUWaaINY6i6+958fLct0ADH2mawXob1ilG
 T68YbtYw+5OIlRlbl/qBQk796NpzNLi7SErcRQzmlUMUs51ISLKuFwWXL4iqfzZYao76Bq4aEdb
 5CXF93eMZswF1TU7qw51gvMDZhCEav4iqPx6dyPGNX1nKAiHM93sBuzF0wxALPB9qnpKWW/pRpE
 lCSqMHeLYQBg2fVTeH6ccGJS7pdP+DKQ==
X-Received: by 2002:a05:6830:2649:b0:862:b76e:3a73 with SMTP id
 46e09a7af769-86315a6d398mr1618615a34.29.1795127200885; 
 Thu, 19 Nov 2026 14:26:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168c1bc5sm649069a34.6.2026.11.19.14.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 14:26:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tomas Paukrt <tomaspaukrt@email.cz>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <x5.ZqLK.4Vgk35A04mS.1gxhix@seznam.cz>
References: <x5.ZqLK.4Vgk35A04mS.1gxhix@seznam.cz>
Subject: Re: [PATCH] test: lib: uuid: Skip v5 UUID tests if SHA1 is
 disabled
Message-Id: <179512720031.764313.13177368498572256108.b4-ty@b4>
Date: Thu, 19 Nov 2026 16:26:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 06:46:35 +0100, Tomas Paukrt wrote:

> The v5 UUIDs are based on SHA1, so gen_v5_guid() cannot be used if
> SHA1 is disabled. Skip the v5 part of lib_test_uuid_bits and the
> whole lib_test_dynamic_uuid test in that case, so that the tests do
> not prevent building without SHA1.

Applied to u-boot/next, thanks!

[1/1] test: lib: uuid: Skip v5 UUID tests if SHA1 is disabled
      commit: 63f1ce6cbcb2bb0fd21059932e2926f3d723d25c
-- 
Tom


