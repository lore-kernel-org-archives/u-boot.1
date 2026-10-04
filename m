Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B290DCA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF23D80C67;
	Mon,  5 Oct 2026 05:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j0sYCDwET8TA; Mon,  5 Oct 2026 05:12:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E238680C6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177154;
	b=G6WgIVsFb4Tk9aTRHRWDvIMBWh6OTLSCEPDIedArxzdorkO0UyLKw0M7iR+a4WHQd+3F
	 /nYzmNaW7CTtYbHGmJTBaoDOk3uFc1dysfWIyLMStaiwh2SiMdZcqnM/40Srna4xSXaJy
	 eAohHj6pwMHS/P+2rHzqNY0YSfOMJVL9halk2A8CuG+siv1hVNmpTGftMcOLTLfDa8r//
	 N/kid2xWtLx/TL4p2Cu/M8bWISt0kV3VErBQ7NU7UIaAdYsgr8kuWKZW0rPyp4WbcrJCa
	 T6EdwKdVdJJB0YOkd+JVgRk1Ho527s1/C48c9fq3UqicnVfo3t3mon6UVyyk9lc5owg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lUlVw+KNDR2Vh0o+z/PtKMONFrtzAQjnHtGbrbQ7PC4=;
	b=qZBrI5LPE+gQ+dPgnDQRQSbo8xCcQX9nDmU//oK2HKUPn+XOsyc8eRKYEpuqXpf1AVTw
	 Jm8ZgfSuiep03yBpeqosa2n9hp7QoD+8Oj2um5C0hAByu6pXAwddPxN8K6OkGXAB9d1e6
	 SuNu3U6ccfTYdIFeO3aw3Yulv9G+JNzAiAQNIY/KpXrVMvFkuSIzruP3MWGUVRd8zigQo
	 tvH97zs09baAivlf+29jjcQED0o3/8q5vQ815d2aNJUf4wAh1fAQubHV+oOIcJ1UrMQnd
	 ztPc+2RALcOsOqi4qo4UNl1vHVOYxXnUeCyOprdIhB8HKIzndDYwafT/CSciOKNDERw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177154;
	bh=lUlVw+KNDR2Vh0o+z/PtKMONFrtzAQjnHtGbrbQ7PC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JA3+5uzIM3fL0cB4iruEJ3xpj0XU/TrjDKiZA1FzO5l1xIXHMK+CoFg2lfDwPBy20
	 +UFh/yXmlcJkYfktxRMEDT4+P6RVbI8vVVZTgeyqDUgnyb3z5BzB8b4YmlzSTdl6ly
	 2YLPw4W1bBRKrRjCQiTaReswg3XLqNHgZa8FqZ8gHM9yfzs0r7/u389qhSz/ediMtg
	 u0z/uN0j/rWyerbEsaBxpSfsC20x9ZRKJi8jrHSt+W9HKqzFOlrHbtDmnFHghkLPM1
	 wCiMD5ZmndAsLaNWVU9P+EJgHJ7YPDcrezSzDn0U6sgKErsH3+yeAKhWiEve/Bkv9m
	 U94+/4e1nOmdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E238680C6A;
	Mon,  5 Oct 2026 05:12:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CE37933
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6288740082
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydBUy1itbqUA for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AD4A240068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127651;
 b=W4NYI9Q8zFR3FB/ZRuIgPfUinA9JwNtJPkuQMuQhGBrmGcbQCruzua0QKl9M03qXpjZb
 OuFCw2er5Lteft0zHEDMRyF7HXNeGfbt1YgSnBYPv7Pp8/ejKwK/tsNDsTXmzcPNMwa4A
 SDANufLwGUqMiPl9ySTlXI/2iBRTRNCuVWsbha9SRAveN7huEZpGDEPGc8CHLWgMoW6Mx
 t358IkdJLLy2OeBryqd7vvBlr1WkR+lmS8KO3kn5+5rppw8w/IEy0mKZgVuUbA+AhF0D7
 xMOdWdHhDYIdjE6h2zDE8eFuykL3gTpd3xBiN8NrPIH3bnki/8Y88rcbi5C6Oy74CvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127651;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=lUlVw+KNDR2Vh0o+z/PtKMONFrtzAQjnHtGbrbQ7PC4=;
 b=pEMU4Cptd4no9wmwrHwMFFnW4ztdbhGVP3Z3+O4V9/xS4kU7Tw93cuxepY0nSBK6KQOb
 Rqr8opkm9XfByFxCBoZnzUoW4tfc0A+eD6sgjYtc0z+3PqfqiAL5XdpDkrYf/ic87XhzB
 sn1kOYDjUpU2fZR9lQHFmm07QxD/FVJRKOxQ9HuuQGsFsY/PI2RQmnWd0tMkzGXCheeOK
 j3wVxijt35vQyft3WCJ6GehpuSLYB+Bps+F1c2KIqYdv1D7lB6jOlM7kByj6f77Zv0HHG
 WTyFXRay1q2/mphj8M3hc3K7JBLlMGb0OweYkN8Z7Rwcms2sVHCAKVGQvK84/f5CNnA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=HzShhSVk; 
 arc=none smtp.remote-ip=117.135.210.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.4;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=HzShhSVk
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD4A240068
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lU
 lVw+KNDR2Vh0o+z/PtKMONFrtzAQjnHtGbrbQ7PC4=; b=HzShhSVka6TSCmONbb
 6hPZEA4xcyCUCNvnz42M26ZYNa2IRuPn/wq3B3tFrIn54pm6EiC6BDm5x2ivboA8
 BEgXuriILYE4kDMEG8ldwkvN9la7dTW69NpeDUShVhYd8IgRkfn02hpHhYOz1iGc
 zTv7r4xG4LibYVx0RxBvrKH9g=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S4; 
 Sun, 04 Oct 2026 23:27:18 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 2/5] lib: sha1: use memzero_explicit() for the HMAC key
 schedule
Date: Sun,  4 Oct 2026 23:27:11 +0800
Message-ID: <20261004152715.1574-3-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF45Ww18tr43CFWUXF1fZwb_yoWDurc_Wa
 4kA3srCw45Ja9rArsrtF4aqry09ay8AF1UCF9xtr4UZa4Fq3yUZr1ku395XF98Gw4fuFsF
 9r4qvF40va12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWWlg7UUUUU==
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbCxhd8F2rCcFcHpQAA3X
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:02 +0000
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

The key schedule arrays in sha1_hmac() are locals, and they are cleared
right before the function returns. Nothing reads them again, so GCC
removes the stores from -O1 up and the caller's key is left in the frame
as 0x36 ^ key and 0x5c ^ key.

The only caller in U-Boot is the TPM 1.2 code, where the key is a TPM
key's usage auth.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 lib/sha1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index be502c612..94f20fb40 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -373,10 +373,10 @@ void sha1_hmac(const unsigned char *key, int keylen,
 	sha1_update (&ctx, tmpbuf, 20);
 	sha1_finish (&ctx, output);
 
-	memset (k_ipad, 0, 64);
-	memset (k_opad, 0, 64);
-	memset (tmpbuf, 0, 20);
-	memset (&ctx, 0, sizeof (sha1_context));
+	memzero_explicit(k_ipad, 64);
+	memzero_explicit(k_opad, 64);
+	memzero_explicit(tmpbuf, 20);
+	memzero_explicit(&ctx, sizeof(sha1_context));
 }
 
 #ifdef SELF_TEST
-- 
2.43.0

