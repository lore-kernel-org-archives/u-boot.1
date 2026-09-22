Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6776EC98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 256F48086E;
	Tue, 22 Sep 2026 12:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BwrYYkDrFdS; Tue, 22 Sep 2026 12:47:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7308D808BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081256;
	b=rzaJACkoDJocxb/l0pW9YYRCXYDYvKGyHgH8PHf8dy7vpoz50RNV0Dmx3RxOC5MlaD52
	 ElA3OsmpLNtP1pRx4Y8MogNioc6ywAtZim+ZiUK0WleBAH//sZ13rOw0ZCmGM1IaVZmlu
	 kzUWmSuoFfHvGIx7CZyFsEK6aI4rCn1VvUGP5gfBA3RK94pBC1tocHdCYJz41ugq57B2t
	 72U3XqsKUi95g7UknNqzUKeEmHj20Bm5KMwSuBBkkAhdGwxKDlWqBfhQ+dXb4UTmcjt5Z
	 uQwAZKnux+ZiB/1h/s732mSFPngfDCKh+K/Cjf39973+ewraxH/PA/xMQPfwIhgekpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ePTPpuRvzog5bXabZFM/j8Qewp0fR5S/JXlKykX9YZ4=;
	b=HdBTeBvL7RP2H127df387grm6JeSB+Ul33FwWnhvrFBWLtnpolCkUTFSuIwVrrxobi3V
	 J4/L60fzfkR2ZH01A/H05h7oAg730ee6mbEz/KOSC9iwkPROtS4vg9kVMMDhUERL80WxM
	 ZWeT3fTumsDwwnC70KW5MqI3OrFwQYVMZoUKtfEk4ZHUt90OPp9lYh5wAJh8vIyNEJe8N
	 p363f5xzJyW5UMxrCAI6Tvw7huUW4Kqb3sZO6iJYHwwGnvxNBakumJWfpbSl76DMQwQPq
	 YOdUu4qXiumy5RABalYCi4/kcA4yJ16b0iy46auRk2wl9C0BWA8WTGqgcIgeYmARCzw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=IqFm598W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081256;
	bh=ePTPpuRvzog5bXabZFM/j8Qewp0fR5S/JXlKykX9YZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VXbqIVnwb6PNFbk/C0DMdq0yEF5nm7o0p6fVJA+/QL6Gr9thY7iDTxy8m8eZ1XHmn
	 osDB7pLdmy8KSDMwhKnZfswHrITjFMIw15RD0E4g2gi+NyV5svQRJHvZtF03pXUI4R
	 zyUOYLGXGHWAxvh2QUOK/qwJeNZ2nXUOVcdl9gZl0+PUEkp4VvRpBShWqVnh/cC5Ql
	 pDzkhzmtO5v1A3aqkQlb9chcer/bEEppM+b2AyQB30Q76M3Ou+O//8yykzjhg7WTUy
	 7eupSTMsczkCCME3LYvvaYGoT62lQP/Hp0V+SpyBXtSiw81llGKPo0FaVCPyON2LXZ
	 XK4gCvDH8FYXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7308D808BB;
	Tue, 22 Sep 2026 12:47:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BDBA12C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1C0980E1A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ISvAkHpODE7 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DBBC780E19
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080621;
 b=A2tun+1zcVS1yfiSTSr2M95C5raYv8Z6KQRckOHkUDON3bflwoHtbeJgZauyjdzfGgVs
 SmSdWiNjTnd/NapSExokPE2/RuPqMYdoe7c6Aj8gIkIi0PI6vwvzxlxK/GMv7wnUAKveK
 Z/WPDkX6rU1cgxYB/TQuDiEFBk+GM5kUuPScRPDiFgNKlU/jz11zVxeIn6oLZ7eX4MUMG
 cwDyP8l51dd0J08nZNIqLCk7zE0X5Lbn0m+Lc4i38ScoTxhYZItbqyb6OJBHQCBR+pEql
 jdu9+OrurQicUqvA+KKK/2vvax8k0PuxNn89ARcQRt1J0gFxSTtXFSjVwjxM4Unp17Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080621;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=ePTPpuRvzog5bXabZFM/j8Qewp0fR5S/JXlKykX9YZ4=;
 b=WMQUaBygV5kaNhM1w/MAh7imgAK2xGENc0fHfnPsHdxgx8OlIKReCm7ECkSQQ5uu8wmP
 fYm/DVVfqKLXHSZKXRwnJIadug7o5GHBWFCYN3fzVic360xfMer8uCt9e9laOGXxYb6W2
 0XlHCbA/TIwSn9F2wZMHXnIhoyKgzI9WPoZDP2/5b78zRxElYzB4/MXOdEmqOhbeGdX6t
 Fsq7zrioARVmKrXILfpN8HKCTBlJ3bLbY4ItKHTwudNt3cRqdT677mIdS6pqvgVlHL0oK
 KQJ0QGa8YwOO2F6XH6mtQuL21YRz2SyQchQGNgORY0DIGX2KKwxAWEHXAQLDcuElSRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=IqFm598W; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=IqFm598W
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBBC780E19
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:00 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CE6B3F2EF
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080618;
 bh=ePTPpuRvzog5bXabZFM/j8Qewp0fR5S/JXlKykX9YZ4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IqFm598WZXTT6T7gDASAFkElR5AAZVHhwWUdWyXPWn6Qh+KxurtDIJwe6aZKdxEli
 PR9BpmoeHcYgTp3UomFUqclsV6nUgyMJlEoffRBsKLbYl/+vJh5jco10kC/sHNs1fk
 ncf7UNg6exf77p8p481EHnrMInu/10rX9Wxy/vOXh5bg3Q1xmNcMx1t7kCdK6pRQ1J
 oMyhQa2uuHpC+JAoORQM15O7ID5YT34KTMrKmGcdPHfrqPkFGInyEiOX1naVU9NigV
 pBfeowRtFv2jjvOYf2NrF3j/+G/9u3iQQpWirVk/txDJIdo7EI79K2xC6nwBZEzHf4
 wBQEQTsF8UcrSmMOlUROFMJ9Ad07hE6aKYI0YkELy2l/UElE7BisvJrS8/fAM76hsK
 C5bvJFLRvvM8l5IoRT47Cnti2ysCSwK/alN+lmmCTQ8rH0X5WAIIEJJ+wTY8+mZAAc
 fTgETrQV8o7uSDcEHj53lLtpqHrCDxzTzYCeRoVSLqWd+xZNuqZHZegrnGY5vU0uqC
 WOl/oOfp9eTTIY8ozvYD34htwOaII3XRgkrViHTAgqbvO1J7iTebf8FToMQ0AAxXxN
 mW5ruaO3DF1Sfa3ODqGfEib/Nc7yr1YeTbYox1svSi5Ef4dvLTPbawD/tD+NWEASgO
 GpTaR6wVwRyXwGhhoktj0O4o=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2dc7337e2a7so50229395ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080617; x=1790685417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ePTPpuRvzog5bXabZFM/j8Qewp0fR5S/JXlKykX9YZ4=;
 b=qvt50Yf4+6wm0EjL7LKVigb0ukNAm17xsh3LtxXrXNqp0KUE4/oMjRKVKEe47ImxvX
 LOgLKFKFMejv5b0x14NUHRVaiC9t1+Mgri+/Ebn7kWiEGPCQgyB/McOzcmCT8THNFXYV
 A8HbNqBZ2uuTcE0bhFkJF3EK68cKoSCauxaod7dT9Qk2cn8vMtJDa8T9Sse2Awymn9Jr
 RSuOo4KksKLAaSmX3BXtIa9i0C07xvnUNxWN5r6dRMGx17uu1x5C51v0D6gn4isn7e19
 BcZDFRswluBWgHSxPmIzzUFmDJxxo0xQJbwtJRYMkQyoDIW/62xf/st9810XXtwXPfx/
 OIEw==
X-Gm-Message-State: AFuF++kJuXLEjsHaNtivaCPT9mvfAqVALID1upWiO4AoBEA6QPn8vFjt
 L60emk1emz6m5oRVvf99tVFvdBh0GggT+fucaoDZBJM0C1QCtXGyBpf7G9aeQMQLp19Y5BAejbE
 tHKtJB/kUDXIl4rPMbmtEsTWqgOfBLZKecwvEU/wpq7U9pcYGwranr/DTSXK3WyQ2yJBKV4vPPo
 qPJCP4I27oGqHG94Z7LA==
X-Gm-Gg: AYBFou2sPZeAKWrk4fiH8t8QV2z1zH0LnP21mSExXjDu0/kX62gjSmN0cxyRbKeg/Is
 y8LTbqpk15t589hQM9v2uCg4JKimV5CCeAI8pylaZSLnXiwLbZyyA4z4HEir8zAh2goVR62WPul
 2/aAc1gWmZpq1zILbrtM9CgGfwuImq6qKkwDHJYVFj3RavYOwJmClNuTs+8UTKMyHNUi/y2qEJ6
 qcf2smVZuUnjI6Uy/hysY0BhYGBRlu0FHLJLHjlLGP25wwBcfLY109fIXYcizmZWdHxp1X6KzeH
 utVKjwWv+u7xGmVjD2Zbz8DCWmFk9o3TJsrQU0aa9PsqWoprSZ3RluLTGUnJS/90fYcPXWsxYdP
 Xoon+ExyODl/RmLugf/drIYldPq3gOUvXDO1r6+kWXQffru4Ve64=
X-Received: by 2002:a17:902:e746:b0:2dd:c053:e0f6 with SMTP id
 d9443c01a7336-2df60b3ad12mr13071715ad.37.1790080616819; 
 Tue, 22 Sep 2026 05:36:56 -0700 (PDT)
X-Received: by 2002:a17:902:e746:b0:2dd:c053:e0f6 with SMTP id
 d9443c01a7336-2df60b3ad12mr13071395ad.37.1790080616373; 
 Tue, 22 Sep 2026 05:36:56 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:36:55 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/7] include: image: drop the duplicate FIT_ALGO_PROP
 definition
Date: Tue, 22 Sep 2026 12:36:21 +0000
Message-ID: <20260922123630.608961-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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

FIT_ALGO_PROP is defined once with the hash and signature node
properties and a second time, with the same value, in the cipher node
block added by commit 7298e422504e ("mkimage: fit: add support to
encrypt image with aes"). The identical redefinition compiles silently,
which is how it went unnoticed, but it suggests a separate cipher
property where there is none: the 'algo' property name is shared by
hash, signature and cipher nodes. Keep the first definition only.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---

Changes in v2:
    v2: new patch

 include/image.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index d991b4c2bc3..d80834049e5 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1158,7 +1158,6 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 
 /* cipher node */
 #define FIT_CIPHER_NODENAME	"cipher"
-#define FIT_ALGO_PROP		"algo"
 
 /* dm-verity node */
 #define FIT_VERITY_NODENAME	"dm-verity"
-- 
2.43.0

