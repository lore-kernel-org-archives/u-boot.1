Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52A606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZNNxC3hp;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=myNWMz/x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EDB480DC1;
	Wed, 28 Oct 2026 05:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6b3s_fOi7Sq; Wed, 28 Oct 2026 05:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57E8880DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166663;
	b=CFyzk5GYswGki+3wWkVCQcSnfOl8VxFe3n2H9oZMP61Z/Loi3z1A7/RzpG/sBNKUwLwk
	 qQqvWhGLhjiiqDnR305ZbvyaHClr0r/RiVGZPetrlJV54Z3eo8GB/AD+o6Oo/ohuf6tff
	 W3abqYkeTASfecrKr83KibkF6lrcvt4OQ5M6apUoJLpd1eJj9WzL3Rgy6x40zXhqc8Uni
	 Nuuep/l8cZalfbHVU7H4GejGHSYE75A1KoD4xQuaBkaOWo0wmONrMyxIr3RAMgMdjetTW
	 dipxG4TVILC6nV8IYIjQadu26Skli8KEnF3jQkpfSpJoPt5R+eLNI+lpepBG8uNRyiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LUTVgN1AaYwutKNHfNkejcOi+OGoIVmZJuw0Bi7QIuI=;
	b=gt3PsftTQA9Yq1DBHz1EQFxIv9rv5/EXlrMG4+/D63JwJeeJVVzePaNoO8ZqeZIO9JJE
	 73vh1MsV/kIreWsISoA22bEPbtNgdB5A0Cm6Lhl4Fsb9vslL7hnHqYcz0RFuDICp/f9UK
	 5s/YPORhJ4mHGEjR5OEVTwJImeWwSd/h9sN5dPmQRSh8jyOD3xSPX+X+PKdkpvhpfke0o
	 vANsFwVyQKFoNNYZuN9tqrwoVSpBkx+2EwsViZ1f+dbsVGhd2okKNYkRqmmtmhOl+mxEm
	 6UkECuzD0s95vPe8j9D8O25tWq1qzU0TSuYNhLobK7NcfO2OBEh/Tq4rBywgRfrOvDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166663;
	bh=LUTVgN1AaYwutKNHfNkejcOi+OGoIVmZJuw0Bi7QIuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZNNxC3hpnvDRsqgAR0bzL8KMmUMwLqWJZbHdvGllRRaclRRAJHlt0WPGGsFWLOpVl
	 mC4peUuY6LpBb1VVfikAAPMLNU5DsEK8SxQPD55m4KdPOtnR45cPoXHCvmXJO0Xyjx
	 HXA9yVm/5+0DN82ACOieeAFM/WXt3CNN1mKNwyp4v7MEZLK5Eu4GnrXzu7Wl+Nq+8I
	 1pL0xh5dGQDL/a1j8ot9geaEBbvG3KBXNhNM9FEuA6GdsE9v9FYVfzDQvxt7/eEpNO
	 nITJoYnHzEbCFTP+P4PeNZofJJlbzxhIjXBe6FnK8IbZCgUZMSh+Eh3ByxEJkdD4dx
	 hXWvlBPWxJlkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57E8880DC5;
	Wed, 28 Oct 2026 05:51:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AA8C2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B7E401BE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1-yzoS9fIV0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3FC254006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166659;
 b=PQIqYbHKS6cAqVi0LnDxDP88Yq2h7EOPZ8KCy4hM6HCZEf5S2QwCc0WrEyrd+9VSWTra
 P+nIGxbT6DD2Uj+5afBL6qlUn7WwUyjE2DdmS+WrM8pOPplcfEEKVO6Ub82fZ5hhsrhp9
 GV382xk6BwYtiauLthpbloaL0oMb3Pe+XBpfU+/Mkk8+vUoFZNg64TKLokHZJypAQhTz9
 JH3pEXIDCAZnhPuB/R5LnAGK7hNm2g8eTJpOnIxHmNmhn2UMlfpdarFVrZPRGwpNIQ3ak
 sLgAiZPun7sHdoQ+m/bXH1VK373il70zZeMZjD3YzDtoLzUw4Z4WmeAYcFOHEHMGvNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166659;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=LUTVgN1AaYwutKNHfNkejcOi+OGoIVmZJuw0Bi7QIuI=;
 b=DQTb4jeDV1RymKGrKzVkl3PcmhAOZTzhDE/9tFb7URANE6zaaZMA74U2cNJtbAfjJ1If
 tSi/y8dauQqcMfiGuWgHGDork59ZUCL0iiZe6NisG09BCTab/J1jKOFjyNxNCw11HepJI
 PCVW+I86QPd69kfgpo4YWQiqTpCHYSDgUsfe2EebyjvWqv0WcvJry+YCyVgKbeToUObnx
 Q9ZPSAB0JBA6dDPdBba5fPNhf4K2Hl1ZK3haJM1HOqwbVlTJCCMJ+juB1PPefFPI1sNMf
 RPh6Xmwusq5DU/F8Fi9NZRWG3vgBb+X5Im26Duryher1W1WHF185D20D7mekUXF/aXg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="myNWMz/x"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=myNWMz/x
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FC254006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:58 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so298923f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166657; x=1793771457;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LUTVgN1AaYwutKNHfNkejcOi+OGoIVmZJuw0Bi7QIuI=;
 b=myNWMz/xLyQ6PGYm9iTsW9ZqFLIaoSqPaabsK+9np4uV6diMboLFBjPbPRXlPU44X2
 RUdjBe6A9H0IiH5q7lG9tYNlRgxI2cmpDYqUmz11QHUzm0ZJoeBGBGgZYOLphJ5HDW4Q
 wYNMvHaEIbcqdiFo6491ENxKf1moOcmtnep3nFOhgKkiVMPvIsv7aGmsTfEb5QUE70EE
 mg8V+bNoDDaOyNNZyJoZypmX6GsXeX63qQ2pjTgdATSgYUO0BS6dbnf5yhm93NFxFJN4
 SXCMn/bOx3CSpE99cQwMBAU3CvEekvdPCRqsdRV0Hu3QTPhcCeBrWTkQngTbxeruPW2P
 Qd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166657; x=1793771457;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LUTVgN1AaYwutKNHfNkejcOi+OGoIVmZJuw0Bi7QIuI=;
 b=mH+R3QQrxlEvdVkR9eW+jr0Euqj5jFmnHMF5R0PTIjHnp+XF3j57URTFDXyQgHDp/o
 6ptH+CK5QR++VaczVqDbBDx9Sm33VowA4HDY3m96dqGD07SzokW2iVaFsnZOjYyc4But
 PvcjMyugr0O6grLfBgH+40Vzj27JmaZzgvWg5DUhv09U5XXsl1zVC25bBegBQ4Ond4fk
 BhnS+dGZnXkaGyrNkLxZoJ3KxswFNgwQ2YZeL49+CwXVzNfPmjkaAlTEKmIipl54NdP2
 EJX2sLD+NzDaaaLO91DD+aHYgc+XAkgVx3HKLpVJNUI8Fis9I+z6EwcQRt+A+4LVTmHR
 upFg==
X-Gm-Message-State: AFq9FYKFXGdfpDqs2n5+eZK8ZJEknfwv1EjuGhBsJl+ws0XmShdO2Mm6
 Gip6FGRY4+N0zdYgJWzrSRGou0nB+S8CjhESrw0bnOWeZZulMUgn6x0z
X-Gm-Gg: AYBFou0sTnLlM+CZ4GzoE00pp/oVPI1IQ8DjN0NWNP8n02VTxUyZGhIqy/t0/34zTWJ
 duKYGaVGDRqd5lx7F/tJ1M/ZmMPuBQiulaaMKkkb2pbYbrJtZx/AIeTAO3hSKxdtETuMzIvhquC
 sIczal6NtO0ApMX012KVugxEv+JgdB4bR3a5XeGjDPtwfrO04iJznOJotW0V4jwN4a5CeLrmvnY
 1D9S8wdVuRFgbetJPMM1ECsU9oQllo+UU6kEEdCT2bp6Ix8Un6yxjb+Nsab4y0KLjkjWI0p6TGN
 ye1HoMzPYCQC1wQKbfLuMbVrOGNcfcd0aZR/BcrQb3bbdMynKV+55PpAS6ReZV5b3Uuq2UCjy7j
 zds+IMCsqnoNha9UCRbPkFFP2l5vQkdfVBak7/By0MDlKc69JGjNZtfjV24a3GzJ7DvFCJqxrf4
 SR2/Xs1u7a2ENdgDtVnrNRZ/pcMjQcQAeo9QhRBfnx+iTga9s4avjsog0JeJ0NwldPosdQCMFc8
 czttSvhFUdmeAUh//i6os7CDbXi4bYxYPKhgFpYK+7pmkX/F6X3NAGSXVt4JkyEZxIVMRAtAnF5
 gr38yp5pChrgAYTmo829iydQfkpK++5t
X-Received: by 2002:a05:6000:2488:b0:486:f6dc:52c8 with SMTP id
 ffacd0b85a97d-48e5d5a4030mr3305738f8f.37.1793166656832; 
 Tue, 27 Oct 2026 22:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm25432978f8f.43.2026.10.27.22.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:56 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 01/12] treewide: Use is_power_of_2() from linux/log2.h
Date: Wed, 28 Oct 2026 05:50:55 +0000
Message-ID: <5a883249-dcd6-4cc0-a1e5-868e2384bf8e@gmail.com>
In-Reply-To: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The btrfs code and the bcm2835_sdhost driver each define their own
is_power_of_2(), which clashes with the one in linux/log2.h once a
header they include brings that in, as include/blk.h does after the next
patch. Drop both and use the common one.

The btrfs copy is the same as the common one. The bcm2835_sdhost copy
takes a u64 and also takes 0 as a power of two; its only caller checks
the block size of a data transfer, which the MMC core never sets to 0,
and the Linux driver it comes from makes the same check with the common
is_power_of_2().

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- New patch, so that blk.h can use is_power_of_2() from linux/log2.h

 drivers/mmc/bcm2835_sdhost.c | 6 +-----
 fs/btrfs/compat.h            | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
index 720127468d3..eee7e2d43a2 100644
--- a/drivers/mmc/bcm2835_sdhost.c
+++ b/drivers/mmc/bcm2835_sdhost.c
@@ -42,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/log2.h>
 #include <linux/sizes.h>
 #include <mach/gpio.h>
 #include <power/regulator.h>
@@ -660,11 +661,6 @@ static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 	writel(host->mmc->clock / 2, host->ioaddr + SDTOUT);
 }
 
-static inline int is_power_of_2(u64 x)
-{
-	return !(x & (x - 1));
-}
-
 static int bcm2835_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
 			    struct mmc_data *data)
 {
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 4596b9d1dd3..ffeba740eff 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -4,6 +4,7 @@
 #define __BTRFS_COMPAT_H__
 
 #include <linux/errno.h>
+#include <linux/log2.h>
 #include <fs_internal.h>
 #include <u-boot/uuid.h>
 
@@ -74,9 +75,4 @@ static inline void uuid_unparse(const u8 *uuid, char *out)
 	return uuid_bin_to_str((unsigned char *)uuid, out, 0);
 }
 
-static inline int is_power_of_2(unsigned long n)
-{
-	return (n != 0 && ((n & (n - 1)) == 0));
-}
-
 #endif
