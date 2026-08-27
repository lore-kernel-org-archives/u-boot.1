Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF61C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94670406CA;
	Thu, 27 Aug 2026 07:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njcqbSGquED2; Thu, 27 Aug 2026 07:50:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787817046;
	bh=+uB7gV35SKMiP78g9vTMFsWHd3FnrEuJy1wEIk9KXSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anqOOMR6eahaeDmzFhOvUpQW/cbUzK28gCVUTeMZTTWdzhemZ6g8vXgt2SPczMAJi
	 Xk3Mdl+sKO95V9mcgSIP63tsChRJ/0ST/WqfsobAaG6E/1Dj/tks/m2uyvElS3O+H1
	 O/SBaLPKyq34rLb3DyGlQgQh6tWYPrVU8sJ+iBwjXOTd++TaY0daY/yir4QwDKCI+h
	 171sS6HJqfVldz+Crlsnd2BAeT+48gDWfKWAjBtc0Jf+WOxitRboE6Jz66lISiz+/+
	 5oW3EWsdMS1n/cBvqhQajSuGFzGoASQVIQIt2dhqNFUpdf6gxCn7mP645FxFt6nIer
	 mMvY8YS4SfoYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 988B6406D2;
	Thu, 27 Aug 2026 07:50:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ED603A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E428560761
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:50:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aFLz3cseDhkb for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:50:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=GK4aJmsw
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B9186076F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:50:42 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 31C183FE2C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787817040;
 bh=+uB7gV35SKMiP78g9vTMFsWHd3FnrEuJy1wEIk9KXSc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GK4aJmswZLzM47c4gRT4uUXyPPLRPwMtgG4r09X95uof8DAS5eM8RpErOnCtiJOjp
 zV/KIvFD4U332zhl0CyGRhB+Q0hepl2W/XTuYx5WOZF16Z7RAb7+oMIFv9mV9L8DVh
 hsD6HEtBt9Nb9iFphRvszXZQA7UZQr7qXQ6LeoOdLvv20XQgD2S2VTkX6OPFj8Wvrw
 98n+qxnQHMm2ymGc/rXidWOp1OPM0Gkj9qvJ686KUEC2W6aj5ADtU08sBDXEm+v/lj
 L1MrHxCwgGx7Di2rTSoYCmczmKdO0RPwFQwt8qBZRPB3DFDgNUgMBAS57byyzwvyI0
 kW1jYFwDAGQrrdthk2DaVwaBY8SJaW7Ve2hFok/7PB/wzCuM1Vz0Xf4LalpgRfs6al
 PMMTOHE+Ct67+cJcLvvfGKy8+XAoyhu0RzVCsX9oGKzeCYqjacBUIfIPBBtEQ9MwxQ
 vtstpCJveiqj5bMQ/ijqSaMj2ZYKMNgpL5x88kpS5W18FWmBISpj8FHxfwZjmv9s7n
 ucpIJXxV+KWGI3wkcU1rjjfJCPLXbwe2358Mlr2U/s17Xb40GEQceba3ybYjnJH8Jx
 iyJDSaC5AsEBUDCrjEYoy3tA6TsnpCUcsSwV+OpU31XMmFqrqLODAyQ6OzSRv2Lfql
 OMIWKh8elfYRLTuZ02Spvfm8=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f8f8fde2dso1036096f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787817040; x=1788421840;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uB7gV35SKMiP78g9vTMFsWHd3FnrEuJy1wEIk9KXSc=;
 b=CxTDr3K7UWiqicK2E09pUi89TWEAShxOF/HMVMNGBVI1YTZHgEyYKELguj1OB4ra8u
 0zWKSsdL9tKTMsmHQwD685vYfz2YOQcWdmKwc8uSEXH+/VqzLxD9mf9J44wF5rjJ85Gz
 DEUkUzrTGCmI/nixH9z2WbhPKmlV1AGCMGqm/gNiujv+SElmoW/Tf9AdNMwFfRa/BLr+
 7bQ0frM9QY1u1ZL4UYSyxHV2qlGwdjg8BXfUS0JtqeR5NnnJgmgmahv8ZGbGzUj2XRnX
 YiOcLr/+/cJ9++GKt47QA0FGpWJDMl7wvMHNyP2U9zqCgFOPhT6jDy+O1XgwW/qmpxey
 Hr6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzpyrhLEOcQu1rZxvuBtzEf8Zh5bWMgTY01g16p1XYKtIaauylUC9K3eWYuquv6GKzd2Q5WJU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lq/JAIGzI/7d+I5WwbKeZx76m4pI4bK8Zp90FkXjSxwA5qkDWl
 DFgL2Wo8lYjZMkfm+yVYqsShFNeKkiB7KRPtBKXe14OhHn+bh2yBZOHZDb7kYWB+vlBZ3lsppAM
 xLyRfP3NXLSGSbOo2V06QzpdG+9Ckb3U8jc0dt5XmbAwGZntXh+PB1yaMS/h3f3TeU9Flj+DdNJ
 qr+s7j7n8t/w==
X-Gm-Gg: AR+sD10MIKLo7Sq2EcjdtjtP43/DgCGneI2OaJ4DBrpoofYd09IA/4EBryKHwGz9UcR
 8PtIzDXDtml43UC8bS/3Pt1uqUhpNwmMkgQTKUU487+Mwx9hZU5fizeGNYd5JL9oxYFRl4Q7dPx
 8m1l7bjiAGRFoykmaiEKA+bRaFk1wrmEd9EThAodyDn5SDGC7CYvw5ZaHzhNWIkMZNf7UAFZc1Q
 w2Vag3f3vHm+GhfxCiwre83x7dLW6tahwpNZjd/KAb+wsaheOi6U9QBH9XaI/xiRPAcgHzbUcre
 JqjRAjIlRigf7AmY8ZIj1Kq5IqRYAsG5Za3UO2ClPKHJBBEinmbi5uGtWP5L5pjjMz24OZ2YBDl
 cm/8qnmsUsYF1/qeJks0woDy/RAmQklCSbwcszLmQ+SOfn8E/D9ohFe8AQbJ9MLYi1derg6v+Yj
 T7kq7UWJ8Wue4HMBl7sdFzFmgb
X-Received: by 2002:a05:600c:3145:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-499dc703b1dmr133521365e9.6.1787817039536; 
 Thu, 27 Aug 2026 00:50:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3145:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-499dc703b1dmr133520025e9.6.1787817039068; 
 Thu, 27 Aug 2026 00:50:39 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:d8da:da16:d52e:e57d?
 ([2a02:908:1242:30e0:d8da:da16:d52e:e57d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499fa55f4f3sm40489525e9.0.2026.08.27.00.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 00:50:37 -0700 (PDT)
Message-ID: <b01546d3-f18c-4546-9d1b-58dd267067b3@canonical.com>
Date: Thu, 27 Aug 2026 09:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: part_mac: Remove the Apple Partition Map driver
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Jeremy Compostella
 <jeremy.compostella@intel.com>, Robert Marko <robert.marko@sartura.hr>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Kostya Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>,
 Luka Kovacic <luka.kovacic@sartura.hr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mario Six <mario.six@gdsys.cc>,
 George McCollister <george.mccollister@gmail.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Daniel Golle <daniel@makrotopia.org>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Johan Jonker <jbx6244@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.u-boot-project.org
References: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260827-drop-part-mac-v1-1-c81ede492be7@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/27/26 08:08, Alexey Charkov wrote:
> The Apple Partition Map predates Advanced Format media by two decades.
> Apple never extended the format to cover 4 Kn logical blocks, has since
> withdrawn its documentation, and has shipped GPT on its own systems for
> almost as long. There is therefore no specification left to follow for
> the one property that matters here: where a partition map entry lives
> when a block is not 512 bytes.
> 
> U-Boot's implementation reflects that. All three entry points read one
> block into a buffer sized after a 512-byte struct, so they smash the
> stack on any device with larger blocks, and part_test_mac() runs during
> partition probing on every block device. Sizing those buffers correctly
> is easy; deciding what the driver should then parse is not, and guessing
> at a layout Apple never defined helps nobody.
> 
> Nothing in tree depends on the driver either: it has no test, no
> documentation and no MAINTAINERS entry, and the sole reference to
> PART_TYPE_MAC is its own partition driver registration.
> 
> Drop it. Anyone who needs Apple Partition Map support for emulated
> hardware can bring it back along with a test.
> 
> Link: https://patch.msgid.link/cb50976b-917f-4843-8b0d-dc2a32e59d65@canonical.com
> Link: https://patch.msgid.link/20260825194528.GB523975@bill-the-cat
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Thank you. LGTM.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

