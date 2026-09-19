Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BEDC982E1
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 434D180D84;
	Sun, 20 Sep 2026 15:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E_t0xUvIum7l; Sun, 20 Sep 2026 15:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D03F80C0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919356;
	b=GueP9WVQ3QWB8p6LMViIKRcfvRbxV3zkC4cWIqdeUMhNXzpVI2V5wf1HlWnwEb2Ntv7q
	 /dwNsr4hW5tcQnySvgwEzm5apNnljYQaQaFkgWRW9tkz77isufCUr3ULdRcUyajzeELDE
	 NMwiqmZsdxAEYT2Om82RDdvUjmwoXOkSLCR22ybP57aa7+g8A84LaSncEKRY7woBno0aj
	 FIcrO3VYpI2GUor5iFoRAAiMkhd0GRVwqOs/Wd81ggCgxsrCIiL3nCCpvBF/3PxReI6n4
	 EEw8+i32/HZmDl3VHWJBRcnZvDfxQ8PuRA11OyR6tOLOsTaD94hdA5EENcVaf9cSsmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919356;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DTsmXAKrhZOsFt7l9Z5j8RsjrDTf89xUGTRxT+mlOdQ=;
	b=PWKIrskpqIZP8wv8ccUhz3t1ZX+XaDfZ74RR5e34vROia9+hJU3ZZQlW9Ba87DENNhpB
	 ux/8/NWVPLQ/WFE4tNyP6dtKKJ48Lad/h3XnHzDE/YqK7jzMAl7S3P//6ZDytF/fkLoKQ
	 Fcozx82VhF3/1XNoWs1MBv029NmN4FSICTZh3vE8XQR/7QNu+/E79TtIQXEykJfi9Ncr4
	 MqfhpVksqPm9S4dUGo9h7ObQ5uGJqr2H3iTJyWDN921WKQgxwSrCMIiWB6Sdvvm1NlwOT
	 vphfU84L7guzULxE2F95Jfy8RxfjPkkls7ckpW0rMOYCaBieRxN4fIOPgZlPZmfFuCw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=s6+aX0w7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919356;
	bh=DTsmXAKrhZOsFt7l9Z5j8RsjrDTf89xUGTRxT+mlOdQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fPu6+NMPXO13DplYC6J3Nx46FxsNrPqDSLsG+7YS1CQqT943pXSFldWBoGkzhyOl0
	 adRiwTiBCXVwTS5UuveAvuKhpevoLUbCq+knhoNbj6E6sWxEon5jcPLaFYBb0Uf8DU
	 27I2LLi8lw52OI+UT2pJ1UtWlRI9C+E3rdlcnM+G1vVAaaGcaVwEL7up9w4fCihTa3
	 6MMQrGukrjVSrgZIfn6Tkhxjc+HKtHG7RuEmv2s9aLkLU7F2ocd8A1VRJJnbEWSY6u
	 eOZ8J4DkfFiBS966vvxOaGdTqM8gWY9pworYifz7L8shCPENYciwu2ziVLYN0yyJJI
	 r3L8Z5oYhZRlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D03F80C0C;
	Sun, 20 Sep 2026 15:49:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AF7613D
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 511CC80BF7
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Y3xsxIMoorC for <u-boot@lists.u-boot-project.org>;
 Sat, 19 Sep 2026 21:52:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02E5980A7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789854734;
 b=itTt7lgayapkcA6DAFWelisZTgLrKJjZvz15fQcxON+NOrCfI1cDdJJWVLpL2/knWzEs
 pcTIu2zV1X77HV+Y+jFK7pUbHzDssdwCShAxecDQd0iTaY3B0vfXENyBov0V7n/0LaLhO
 0HT6JX/MVbE6FAjyrHs6CiTR+Xq33BM9hP1JLNGBMyqycMpxnGKXo50GPlfj5dbKmEC2S
 363edK8CE51oukxCPTC7g11qmtgaeKX7zTJoqRVzYIwsHIji+hubP4Na2Mdasb2+bndCG
 b+6To+DPvCW4sf9wKTohBzqcog61ySI1uWXpD0+pDv7jdnub/3aQfJWfmgcmFuLNKuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789854734;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=DTsmXAKrhZOsFt7l9Z5j8RsjrDTf89xUGTRxT+mlOdQ=;
 b=Iyz4Iiee6Ffe0B0/a47x3WuN7Yq1GOj4LyRPCqTQ4yLETELK9Lr9EqKYs6maEOgOzMA0
 KJ0q+oPuQFFW1gQYBWcJdO9z1k0BNfoO1PUCCXm93MyrrdmGO55Ajf8nkgnOT6gpLvS5I
 4zl1tAwLFwtMLoaUI6JcrAJlYzMC1Wm7t7u5MTYF/UdT3S4NuwsumM7EFQKhI9zMPhJui
 8VoSqPSx1NOO38JX0VZLonyeWz8nb8P5yO12YI5a4G8J6NkphQeJWRmlqdejTdJAnzR1G
 9TGjBNFKJ6C/fTeJnPG8HLuKnAssHImiXLi21C2DlzWQl5hYeNIg36y//IoCeopmISQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=s6+aX0w7; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=valentin.haudiquet@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=s6+aX0w7
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02E5980A7A
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:52:13 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F1D83F2C5
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 21:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789854730;
 bh=DTsmXAKrhZOsFt7l9Z5j8RsjrDTf89xUGTRxT+mlOdQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=s6+aX0w7W5Vw9Yx9sAEYiBiE5hXmC7hf4sa8EOgOmOQLCL+NJ8j0XubaHdeCPdUQg
 Qo/Xk60ecDmnDeY3uPtoZVJ+g5cE33HmEwFpPzbUbPBYpiBEdYuPzXQ/rPSgSAXo5+
 mKRHiGjggls48XAKvlMiV0TKyfM78YO8TQvXS2+WuZKaicPExDLAkGbte9d1QZh5gd
 Ty1Rgh3Wo0bdpuCdX5JfkGkCqc/rcTvUvmb75OnAHTmfUrRPOkMGmUdGS83ciSlI34
 ++7HTKZ/0EJju9c/hYfP5sSPD+45VfjDfjoyscZFdXV56UXNUnhhbK6Heo+9D0gO0l
 7qKGBS3ccpbsRBaFjRdZFyEk6TYg/PkPTPuOYi2HKbh3GF+xsXf/0h2v0MjFdm9uzA
 yg4Bc4A7uOQ2gIdfM3reZfCXmNLmM2NUQ094c+8X0dUKbbxpIyUl6XEKbu0VUhrKO4
 jUso2CmNK60/pBDyf4R6AS2cTnPjMDJuUdTBQSlldRMSfLhc5Uch6sm663y3vl1JbR
 BJU/wcCkXeK0g2aXhM9wVra4/lAfep7FC0JAU77uxJIXwudC1VQye7eXaV6dBMCCCa
 NL/HMEYXofZZLTVFMBgMG07kPKxj+Zp+lBcRtTHa2p8jOjCTHTMVW4ta1IfwI5J37I
 PlpXYFU9jIDDWxIM0IkJy84o=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso11153305e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 19 Sep 2026 14:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789854730; x=1790459530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTsmXAKrhZOsFt7l9Z5j8RsjrDTf89xUGTRxT+mlOdQ=;
 b=dJqrBpziJgXhgFyaj2fAtfEnm5u8ysRt2gGgtpkJTYBLCs+hKxd8a5AXy8rLGyMM/n
 bpPerWVWN3S/x45Zl9fyJ8Qbdgno8wK5Z7nkjAZQWgUdgwjzHpfirpCKfQEejkIkBiL8
 J7qdyUyCg4i1CTEeY22JXT7feRitmu++Qm9eiqDz2KC87o9r8yblwOLwHeDEwzfmzOPv
 oRsQl6VX4Rmw15+77orfjCutxZwJgUmu4v7RpcTvFPRsITCEXzj9plfu9n3jgw+6ofKN
 BNr9oBaKrXqphbxJ2KsVo71QQ/R8vPOrXAOjMQFN5l8/oyb5yeA7EIEcUbHL7jfQzucS
 7Xzg==
X-Gm-Message-State: AFuF++mgmqYULPi8RCe/F2GwUucIHjmj+gpAJBNID8f+1njENyzl7UT+
 7dwk1cWdB9pqRqKksBN4frTOGx/TtFQZPjmoCYfqJicaIi2/0IUAwMjIo+saELtdakkSwHD0gPf
 5oHEaCymHUV+lP3efMbwoi2y6h8iEiXS2Tjtl1nZx2e5hTIZqcrNFY/R6g0kcLYevhGYvX7bU+z
 ReYMrBTbMnAFTAJ905Pg==
X-Gm-Gg: AYBFou0+6rJJof7zHVBID8d9JC6UkJl/XO/GrRPhd+c41KBE1vFltiskrIdzqFx6y3R
 pBVbevB925CvDSkSNyuhHMLTMt/G4FvAMj3ijRu0Ki4lrJOAAWqpnqhNXUZTOK3sNdvbD572Gyt
 FjsApnh7o6GRnazBqAbkQqx1n2UR/41pdLoqcLkRIV1ZOaFUPJOI9ylhetbxeu51+1gGXvJuq5F
 JOofOkgPWOdTBzU9KuMmHxuxVTpVLSc4RBRsjhvt1aXEysTHKkne6ePt98rJm7BYKWAtyX8OOb+
 59RE4wUW8n2WH2AKWT1CR3ItR3F1HDJlveS22EqtQ5hp/SFMYj7iXclIiiVUJmYol7Btw6id6aa
 9cTnAMhS8E0qh/Q5ZEVMz+7cNPW8PaG5P5g==
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-49fc56db975mr99037355e9.5.1789854729923; 
 Sat, 19 Sep 2026 14:52:09 -0700 (PDT)
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id
 5b1f17b1804b1-49fc56db975mr99037205e9.5.1789854729674; 
 Sat, 19 Sep 2026 14:52:09 -0700 (PDT)
Received: from k6.lan (141.175.65.37.rev.sfr.net. [37.65.175.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc58ce1ddsm112265845e9.3.2026.09.19.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:52:09 -0700 (PDT)
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 valentin.haudiquet@canonical.com
Subject: [PATCH] efi_loader: efi_console: find vidconsole when stdout is a list
Date: Sat, 19 Sep 2026 23:52:07 +0200
Message-ID: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

query_vidconsole() matched the stdout environment value with a strncmp
against "vidconsole", but stdout may be a comma-separated list (e.g.
"serial,vidconsole"); match the substring instead.

Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
---
 lib/efi_loader/efi_console.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 8d076058280..85f1a9312d9 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -344,7 +344,8 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
 	struct udevice *dev;
 	struct vidconsole_priv *priv;
 
-	if (!stdout_name || strncmp(stdout_name, "vidconsole", 10))
+	/* stdout may be a comma-separated list, e.g. "serial,vidconsole" */
+	if (!stdout_name || !strstr(stdout_name, "vidconsole"))
 		return -ENODEV;
 	stdout_dev = stdio_get_by_name("vidconsole");
 	if (!stdout_dev)
-- 
2.53.0

