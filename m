Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9329606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pIczKk9I;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnpt6uJv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2BED80C98;
	Wed, 28 Oct 2026 05:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LkbKRE5rkyr6; Wed, 28 Oct 2026 05:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F146F80DA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166667;
	b=WdycuN6JetzGW0NE6ghGk35x/OuH2Wtn3X0KKgogFskucKK8s/5qh5BSm/IzrfnHwVmw
	 2618MYajLMeAuu5JOv1SfxBWM/DoSh5oj4v7wzNrJizpZAKcJu59atqpTCV3rZ/o8/3Q2
	 rE+b9uQtSN8jVquyt+yCor35NBtz9sJ2iOXEM68UoiDOZk/43xYPJ05dToUUtMVQLQrTK
	 Nzfo7lpOz28kw7Yx14po/WXoTjHCQyed86OnHNxKwryh5N0aNOg+J8JjeVDatouYxw2IW
	 WZn5UAZf52GrmRKNJxxEjrYoPTILbDE2RkM3NS+wOeiBwADrL/NAvk522UsHcpc955w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=HeWek7+oU1p+I3Ln+NqJbdqTmON1h2ZTwHfa9euElEQ=;
	b=eUMtjkVoDjBVoeFZTZZ67+vhwOCgakZCYvfGZgnVjOnucuO9C3gdP1QAyaAR6Y3iRjc4
	 aevG5RNROjnPXYPiqkmMJ0eBhcKLXGBJbeC5mXHIyxkzO2xoZQGxDDist3xXJ22T1HJ5F
	 u3a9ELGnb3Y9KtzBaZma+1rQSJ8ItPDaCMBHxj/HzM+M9IWXNSMiYNkUN8feZ844kPwPy
	 0lfuO0btgFl1m+j0dFhKmNUTKirJNIsj0oOZX/AHDHS9l2T7cLrhwMvr3OV1Yq3hn7a5y
	 LazzmtVpNbEbuTDS+cRXXdGn9Novadh4IwYI8/Aa6BRB/MXX1r38o3JfxZ1buPBmJrQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnpt6uJv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166667;
	bh=HeWek7+oU1p+I3Ln+NqJbdqTmON1h2ZTwHfa9euElEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pIczKk9IlrAuOZpjc81kMHlTPV29VofGuHfUFOHF6PeUAKrwpwZQLqreqjk5k3Fxu
	 gzieWhKk/xozX6RNCSlCKxov2TgkMYyFKKxDNLPKSHM2muSkYr9urvlsBVRZUsZbbO
	 Nkv/7aGn8o98y5q1596+cQLCJOE+3u5tZ2Q2zHYhFZWHuge2Gm5ZE3vQqDcU22vkzq
	 J8eKj+ZPapP7fioDojMvn2f7QkuZinsEeY9gafOH5Pu0mOmAryysUX9xhU1WfDg+VA
	 w9zuzquFGsTGolT6JoGI/YyVxi42t9ZjgMozkhyBQcc066PTE9lRNw9mL+XbqwqLKE
	 7lY6mZluT58Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F146F80DA7;
	Wed, 28 Oct 2026 05:51:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E1BA4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E833F80DC5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aWINtazPmQd for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1DF6780DC1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166662;
 b=cJHXFhRKPwTrxTceP8vpqN+sG8qC2EfZoVXi91HzT61fW+GovuU2gfWQmnJqjFiN3SeH
 FPOJydZkyjtoZL8A58fAedJzrSVrURse078jNUzUDH7zV1T5JhmJDf0Alx1BxINrVRdPY
 BW+ezDuU2dGm3wh7fqJ1nhq6TYNwockJbR1twJhoc4GU9VfK5o/xCtr+KjNwGFzrbAMBw
 MKjkb++ynuVEAQeXQxkM0w7wcwtKY4KkV83LCNgru67tFOlLVuDeioHJJTaRtytfKdcQN
 v9bwPUMSw7kCMLh5HsnG62GPyNlmL2vrUce/Y70+H6encfuPghZCPXh490cJiDhqg9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=HeWek7+oU1p+I3Ln+NqJbdqTmON1h2ZTwHfa9euElEQ=;
 b=dHBxrRIsmroIxJrDPGw4/00R9BGmlGOaeJy1AWC8z/GvkhFQtfajKKkMoboVGsfG+V4w
 bLeOac6ao4BssM1gTp99c7Apw/oo/bPfs2+8uFYYjrT3bpMz8KiRvwGYxyuldYRALf3RT
 B+ICgpqVp328A7G9i9i1qVnw0lmMbSnvYfH3O0OnRq9YuTB4n+A2TAIZ7Ngy4NjkPePo+
 HcfEZOvEsWo0MRvrYOMU6Qumk4by34aaQrMV/VTyyqmlNaI0PJOmAVQ97ZB4eJLxTjxIX
 nuqkkBdLPOrbTnfTt5qSR3E2R7IM1IjBwyz2PiG1uVJSPzZBuPrxKYSt7ca/79/u5VQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=hnpt6uJv; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=hnpt6uJv
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DF6780DC1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:01 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso409408f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166660; x=1793771460;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HeWek7+oU1p+I3Ln+NqJbdqTmON1h2ZTwHfa9euElEQ=;
 b=hnpt6uJvBFI6GnQewcjvloSs3N+2Ezh9xAtbubbY7HLTHJn4c7oKfyUAaAtFPIUoqN
 ehy8Nj9J69pxfGwycnEXNXQZGXbjqA6n+1NBFgYRAAUFwQMiREpfjjHN422yQYfF0aLR
 Id8Wfrqtb5IvyiU7co1FuSpcqigcjPuZZew/daPaDSyQM5Z4oWEumk6j4OKmviCiaECY
 CbRHOU13ycb0BcVp6azG6N9G/OszuoBNgZU4U+rEafKrqtaSxbeSXm74hdyibxeVnVG9
 rZzRi5DiZPryIMOK3X/KAw5vqVDpIXBOZ2VsNoro++x90D1OX/IJBYio+cIq12Xmu5Pb
 b61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166660; x=1793771460;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HeWek7+oU1p+I3Ln+NqJbdqTmON1h2ZTwHfa9euElEQ=;
 b=U5ChmVwoeOV1mae6IkW7o6R3cjDrgzxHvV+GTbbnXQulwseMHUkK3/UU3HwRYB1cXr
 +V5XNjT+DMVx8LOcVbDuZbGa6O75cuOXhy403gfMWdD6FFApKah8pPnM9ano4sSAt9vp
 ntTIuiO9dB6FVQO1uTAbD2rXwBOpsOgacuazI6cesKTDB31PWIq2UqfMsNwCa4LQHAr1
 BSYDFd3hQgNEUad03wuUu4rPzMs45/knFNTbUW4Kb+aT6YXeaaVWc1yEE8gZ5JfR0GlA
 LelmDd3U6QGalDu3pkXymkpqW5Y8z1+pMqsVuTRZBhD+r1eGGCTSSH6NBFS/i2NKVAFb
 mJGQ==
X-Gm-Message-State: AFq9FYIqA5Aj5OCLrTsiGQffuG7gBfrKWJQ2WhCNqGGD26zpJWNqIqc+
 RR5t9uxGHowt6UcOGW6MYbNvqC0OB+O/U+2zJiYF0cPuMl3pc8R2hwKaM1Rs6DuNho0=
X-Gm-Gg: AYBFou0MmUVOBtCTw536F80bckmcIJ7Z1Uvivv4tdtuMU/s7lmzg8HSSMKR2shLmpQL
 5bdHHHY+4rzcorq21Q/gf06l+auiSerRPWl6j+SGTO8sqewKzjLCmvRMxcinON6NiOedI/IMkLa
 oU9zaZAM2Mp9vZTxvgD9aEO9hlbb5jwm47H3YPLkFsqGCx67y9O2B8hYrcNKV0eS/5iumnlZlM6
 dTSrVG3mnXRblq2vnH7MhzGJk1/P1E/u0mHVaRO5278tAlo5s0+JoQyYNfvfJhK+0fZojJeb4I0
 y15ei2FVioVpk7nG4fc24i5AbEt515/AMcyGc5eyJ745DkxdJBgmFUDJt1G6q/YSH22WcTYZXIb
 sJ4OakjE+6O3E+uzNsJAiSN1htXw0nR0/Q4jcPQ4DPGhaqFg9QE/LalfRecTOHjnGeSpJfvF75q
 IFUnySjrqTss3931C0RonmdMlIHi2p86q7rolORGY5pBZaLa9U4S59fDfYId5UxJIOud+z7spA4
 DrexxHjsUlSg8mTh2qyq9acMGICd+BeB5C7LDVcq84vwnOfdYfvTfKEWFts/JKPG5fcECEjpA8y
 4/MdtjJQf+4kQmOMZ0eM36HJVM+Zu4g=
X-Received: by 2002:a05:6000:2c09:b0:48d:db77:d124 with SMTP id
 ffacd0b85a97d-48e5d288b00mr3158623f8f.6.1793166659915; 
 Tue, 27 Oct 2026 22:50:59 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm24711973f8f.22.2026.10.27.22.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:58 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/6] fs: ext4: fix the triple indirect cache check in
 read_allocated_block()
Date: Wed, 28 Oct 2026 05:50:57 +0000
Message-ID: <1b06716e-6431-4603-9882-2fe8ecf8f0ad@gmail.com>
In-Reply-To: <78892543-03de-412e-831f-de840765be59@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

In the triple indirect branch, read_allocated_block() reads the third
level block from ext4fs_indir2_block[(rblock / perblock_child) %
(blksz / 4)] and records it in ext4fs_indir3_blkno, but it decides
whether that cached block can be reused by comparing against
ext4fs_indir2_block[rblock / perblock_child], without the modulo.

For a file block reached through the second or a later entry of the
triple indirect block (rblock >= (blksz / 4) * (blksz / 4)),
rblock / perblock_child is at least blksz / 4, so the compare reads
past the end of the blksz-byte ext4fs_indir2_block buffer and can
make the lookup reuse the wrong cached block.

Use the same index for the compare as for the read.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

 fs/ext4/ext4_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 3aab1c87233..cff112fb99b 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2008,9 +2008,9 @@ long int read_allocated_block(struct ext2_inode *inode, int fileblock,
 			}
 			ext4fs_indir3_size = blksz;
 		}
-		if ((le32_to_cpu(ext4fs_indir2_block[rblock
-						       /
-						       perblock_child]) <<
+		if ((le32_to_cpu(ext4fs_indir2_block[(rblock /
+						      perblock_child) %
+						     (blksz / 4)]) <<
 		     log2_blksz) != ext4fs_indir3_blkno) {
 			status =
 			    ext4fs_devread((lbaint_t)le32_to_cpu
