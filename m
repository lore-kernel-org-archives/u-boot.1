Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E038606A32C
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0idOqfTR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ps24qfFu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 184A881499;
	Thu, 19 Nov 2026 18:42:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEH4Gwdk-WiN; Thu, 19 Nov 2026 18:42:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 670FB8148A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795113771;
	b=MVECjt2+FVhpf5cImLPQnRPvhpD+G9/E2ZxeYEZrsEcE/TsFO4k24zt0v6MlYwDCS3Sc
	 lp8imMsZvxCry+Vqxhz9qxE9GjAHSfYTY0WtgZn2Ru3j1Yp0bYnXA3ydfuIjjlMOSzeEq
	 1SWGXQj3UNYYBoUM7ujF2tmtSIiJTdakjU3UiuiltvQIYyLSGZmb7S7Vz54kVJkjs5BHe
	 XrsTJi7G1Rw1uF2gLKFPMV8zqWmVX/1vh16LUZkpyyZVTyvPsO4lJbl94BQJ1p5y10G7W
	 NwxvIJ7yzeGdfYC5hSDhWGaJq6jZ0IK82D/EnPGkk54JO9iiAkkKwQxJz71fYjuJ7vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=b3Dc0jCfxAROHYfD3XK0LrG/RW8sQftrbXV6R9U7sGw=;
	b=hpJQQdEhDBRBZMvI6JnSbu49Mq6DPm3Tcux/CZbgL+rY6WYC6IJjh1y5Ikm0GXrEzwJR
	 pIyMKsBqj3P3+xm1SFVX0TEmVuHWv19/B8WsWgS21Z6ha6rurxkIhb3juVrroTfSKCq6d
	 3SMNw65MeBZbK8QUZiWsWQFU3jUr4m93YsgG+qEkIg8z96jYi4y7oo/uUjhn/XR4FaYWj
	 MPs7gqBXMAVQiqwuuVpC+1veaaZ2sZ7U4UeNpEc1zAzQtxzbwKsba1nN9YxCnIdJ/orn4
	 CyyEHWdXKMi3vfC65UMcZZ26pHgU9hgjN24liFoaiokQMSNfkUJuIjM1xsmM93+Yw3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795113771;
	bh=b3Dc0jCfxAROHYfD3XK0LrG/RW8sQftrbXV6R9U7sGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0idOqfTRMIW3vFo2J0SJALI2+a3s25m3TpludBkUwyguphzNws/TsK9GISRWsbX35
	 cteVhuVK798QQioqFfR5rTDAw8snXga5KGf/KHbJBlSOiuqwrGbH+TU446hM3uoCj2
	 rP+jZzdeL5Uc9/eQfWbw0kmFnqLFLRkvdFzV3umPn5/cNucleSXs1sxOX4K6aJcIzK
	 0dDOGP+ZL1cmwgjiduDMCZ/d6X5WhSJGkCwN8WjI2ZFE3HckMpX2a38Xpnq8V9q5LM
	 cbxXtRdYj0GBDFofUnC/963tts9ckuTlRoT5XZMeKg29hLGetKTPGEBFClxJHiVs0c
	 BjruQt59ud/og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 670FB8148A;
	Thu, 19 Nov 2026 18:42:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 163392F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0826560D8E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:42:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YqCwQBnQc_s for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 18:42:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 331B560D5C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ps24qfFu
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 331B560D5C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 18:42:48 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1851702f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795113767; x=1795718567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b3Dc0jCfxAROHYfD3XK0LrG/RW8sQftrbXV6R9U7sGw=;
 b=Ps24qfFu7AUvbfO8s6fQybjDEkowcp1hmnNFK0RiPJcvfKrC77E+KGNJj3G+4rF3uq
 UcztAPCXZd+d0N5e2rO6D3AiJWkt44D1FMRKtDFbIEj+Zj99ORxj3KCg5rTcCG7DLEpu
 ZRFlKNNpjWjBX1QTRkcv/YFWf7tG2BVywGJhLzw0rX8wi2nSR7KBnltTDUIkpslJXNdv
 5HkJX+3NlFo3MQdQ/k9I5P19aeW2HScNtigV6Dqq+7YOPsOOz7hHLWAweActOkJ8ODr6
 vXTMmsmNsv4ySrA6tIuMSyOpuBz0TMhWsXGuitI0O33T3DetB9ExIXWI/YkD4pP/NuwT
 GK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795113767; x=1795718567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b3Dc0jCfxAROHYfD3XK0LrG/RW8sQftrbXV6R9U7sGw=;
 b=gi8lEd9FTBPm76ZeMcKVI4ZErmbjyaKRrlzhdcyRstlpXyXbHhmov2Vxmu9WACXJch
 iWU2HKxAHpj4uLyZV2J6lSZ2w36CWkXdaLn4Q3RgvT8xvG6FwJQFvcmNMdNXa0/9IiCB
 ejQGVfDmx1PQTjJmuzdKHB3kEo0enGoV45Z0UqlYpYgjr+sVUYw8HGAq0R+61j1DD1QU
 SDGVJXrczmcxPpAzklIODMADj02aLa6Se2WOS5vWawIsDEzX71wes+wg314y2tm93b+t
 s2+HD5gbaCC3pFi/krft5KXxJSoqbl5Zh50TJq/eT7bV1BiY6yIKyR/oAhhMdZkUQrC4
 b72Q==
X-Gm-Message-State: APuU4Z/EuAbl7k29g3PcJ+uOwteuW+HSo4Gl7NelWxpAq8BoTJmrfQDe
 4cND7g1+FrwtYqy0BLEBJE+dxFD5tHIcLBbv/YJ5TgkKB7wX3o2Iw9K/
X-Gm-Gg: AZFdTZdxU2MRTUxxsRdPvvh/QBLZvyehUH5UtlkU67KteLezO8zPIXxtnTWPWiirgT9
 Tg5iWrottzHKI57XwbqeDboar6RxVU+inxKoOFOPwpmGE4ejd2INjST8IPbsY4MT+8HTgFYmbfj
 KEtuckmR83xevYM7L6hrE+YD9ELCeb31Fk4SFPKMFwjSIDP87Rb8NRm153iuN/sAuZowewst743
 EjH8sU+HTAy0Tbo2YTJUQt7LAAp+F4cM5KQV0kRsPX9dEyGlbEQ9uv6wrwLsfi25aqmL/PZdp9M
 5A8V/JU4uIy6ZxlgGf8ELhrahS80j3vWnF9JYSC4LX0+tzVBSEBNEkllUGLyECU1xWK/Xb/tmgM
 xzwLbOfcbaTfByaS6B8FW1I6aVFlW/4xi4AGuVUuiDXtnSoyv8Pu3ydMAZPk96Oi5dhVs5rKesm
 V3rv/ut4JsUmtLwyf9nlcCtEZ80Ff1FHS2hnmHhxV5uGhGn8cmDGzmNevNr9Lb2LDlN/7tdQJR5
 wh24W5NzgDwwMFBe3yan3xboxq2atc/S14GIrmYSildwfXjmCxGdJby9p+IBSxmvaJAkYXku05l
 Hlr4CFM5UZttR5wWpgaIBZc5+8czTDTJmcUKFoutjsYHRCPG+fpNPQatPcE139RYnNHM2M3rYDF
 CzWfUeonyTC9ZXllU1pukWhq2DzNpZ3gnpCktOaX6T3nSlLDbxedXp2JgRIqjclYSuEiDhN/sBZ
 iBogjDUzeW/WvXmlCO7lNLcbrpUiOE3hj1ncs4GU68XvzsSSV6bMvj
X-Received: by 2002:a05:6000:60e:b0:49c:fde4:1af5 with SMTP id
 ffacd0b85a97d-4abb9de7e8bmr412437f8f.54.1795113766627; 
 Thu, 19 Nov 2026 10:42:46 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf629dsm1091553f8f.9.2026.11.19.10.42.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 10:42:45 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the private
 libgcc
Date: Thu, 19 Nov 2026 19:42:44 +0100
Message-ID: <20261119184244.68936-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <4EDA2004-7420-4BE7-BDD2-B71240E69107@linux.dev>
References: <4EDA2004-7420-4BE7-BDD2-B71240E69107@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christophe, Bradley,

On 19. 11. 26 17:01, Bradley Morgan wrote:
> On 19 November 2026 14:21:14 GMT, "Christophe Leroy (CS GROUP)"
> <chleroy@kernel.org> wrote:
>> Why do we need __udivdi3() at all ? Can't we just avoid / and % on
>> 64-bit operands and use __div64_32() or equivalent instead ?
>
> Oh yes. That's right. What's the point OF using __udivdi3()..

The division operations originate in common code, for example in btrfs,
squashfs, and mmc_berase() in turris_1x_sdcard. All the instances I
found use 32-bit divisors, so do_div() should work for them.

I can drop this patch and convert those divisions in v4 instead, if you
both prefer. The downside is that another such division added to common
code would break the mpc85xx LTO builds again, because patch 5 replaces
the toolchain-provided libgcc for those builds.

Josef
