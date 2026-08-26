Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A2BC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3183880B48;
	Wed, 26 Aug 2026 16:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1lnSdSOkOGsJ; Wed, 26 Aug 2026 16:34:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762072;
	bh=gebY8kpHlnO9kIiQSdGjZ35M/MSRuV1JQIrCyBiVVGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lS1Ujmtk8HcHGYcV0KB0S3hlR05TJYmuu61VC/9diOrYNjU+w2oEoj6m4/5hlR2Ba
	 HlVUSUJJeexi1LwBTRYfVSq+h1vxwI9EzBHLltfZ+1QoyKI2fDYLcCvvrsp0+HkGG7
	 kYnOvCgZylQCxbfezJGHcS1b3kjWSXPr4LtlFAEbfSd7oW97s1FGAqw+FwaqUIcwBD
	 BX1kP6urB4fqnxh5RKmmZ+bFNeP1+0QFQeQZYk8OfGCm0AQ/qP/JrMvkQ/25JxX4Au
	 1E3yDPTBwyUHxlKzqUtQjPWe2Qahqq+MhNF/GjewMpVlASVVe9PiP9w3YNusxLV+FH
	 E37XwtWdp3rYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D92380AEA;
	Wed, 26 Aug 2026 16:34:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B76B0341
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B43834055C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu2XeF_MHQ4Z for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4XNo6OzY
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA40540368
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:29 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a3fda88184so1942291a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762067; x=1788366867;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gebY8kpHlnO9kIiQSdGjZ35M/MSRuV1JQIrCyBiVVGI=;
 b=4XNo6OzY255KZmPCc5MpNdGL4/hMxwLp3YZZrKeqSftbeqTDvRvJ3mcPDaaq9/iDeW
 dQjrwmzZ4UwsxIqMWGT7im8YhtdgyQUtBj1g6epFUL32qUv4hHj8B9gopZXq2ETWcjRQ
 HEylj9GHj4lAb9JUVvxGQGmyEvvkeuhtWUz8ZOMc0ODqcc/gzrCI+KA5y3lDBzZb1ot4
 LR7QdiJ4sOoShCVwfpL0l+V+HKeiih9O8we8oR5OH3h/ztU4S02jCVyfpz3FMhXbD4am
 JvRRSNp/UhBWDCbfv8ijfYECYFdj9EiwGxayVw+1fVbHeNt4s1xAfGV1O5Ldgm56vd7h
 bQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762067; x=1788366867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gebY8kpHlnO9kIiQSdGjZ35M/MSRuV1JQIrCyBiVVGI=;
 b=NS6Aq8VeximukmMkiK9ee5fSt1vS2EX6+gULnY1jVhKPlNHIiIzgzXsJw5Anvi3lfi
 L60+LGI/PoVK5Al97BwQp67SYQPn9j029krVXizaHjh+LQ5F0E8g3jvPFTCrCnVCXCiZ
 38tlOfNHK45+u8efsFH+PsvgTETzyj+pgu4MIB5G92zK2dhTLaoWEupjRaKEKZGLEFCX
 P2YnSZpBuTeEnujI7JwojQ+cPCNOfOp9iwgwcrNssqfVSHjQxAsqY4G7F6THuox+84qs
 SCQ6h0smpN1DPtf2hSf0Woxyp8oedMWtEnmq6BlSOEm+1w4pRrIiqJFydoXiXGHixnX8
 Q7qw==
X-Gm-Message-State: AFuF++l745Z0fSOij+A5ly+O+pbS2c5R5Ln2qwU16/IpGNetC5LmPd7C
 K3uU8rjCQIxF6INaxbJxUH0LODwf/9e6PezReEOy6UrGy/2+a+Re2Q/iWkvbo1VzJJo=
X-Gm-Gg: AR+sD10OkGGTQ3ExXTY1YZ+p4dyad+BUVVYXvU2KKcvolCAxj5CfSvWQcgS0klxSa5h
 bxR3mM5DXpBnAPm8naFAtA2YIbsP3qrKsJ30oIV1+DjK5M8RCYaNCxw/X5lZB4WcQEcgCoOiTBP
 uUhdd0ct86bBiQBldYtQeTaCBYgQx9T6e4JVCGOzgIxKgZV3lW6tZK11zrAOtAPRvcyCdOje3oa
 zpnrcverd3bS96coIEJgNHds8h9tu8IbaitKWyiKlN7kLtZij0lJJs7TxVWZzJU90QjVcmG2pJJ
 gcxs9lvffoIxPTi4CvDNOGcPY6cym/xNoqHR8OeP8mx/4Nf1thouvioBd873R6ezEBVC7lmgPUw
 HPgwy3puOxeeXeQHDgdjCzpAVr75K7yfHAblXNzKmDLFgEg6RSvtliXwdQU8NUQyByg8RyPYZNG
 d/UK1JUfN/OoPK2NXZGl5O0VrnktVcF7JjQS5shTauaB0v34HMZQy6UPTQug0+hAkVeXDaQtutQ
 fTP6WNcQ65OQd3KhdaSX+KMCtMVkhGxWKsjEosgzw==
X-Received: by 2002:a05:6938:a089:20b0:c24:c250:a6b5 with SMTP id
 a640c23a62f3a-c250bc2db03mr817183066b.12.1787762067275; 
 Wed, 26 Aug 2026 09:34:27 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:27 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:33:53 +0400
Subject: [PATCH v2 01/13] pxe_utils: fix W=1 kernel-doc warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-1-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2636; i=alchark@flipper.net;
 h=from:subject:message-id; bh=vMMQDkACfoUgPKSR27Mgvu39TcUL4ZmvuGoXDoE9lQk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/ZMnf2a57pf0rMo4fPPjcRl/k/61t5x495dv0TOS
 JFU628uHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1ah4jw09xh0Pb3Lf1GieKL+APD9k4nevoax+uij/v68XcLpxaJ8bIMK//hqV
 3akVzquchnq0Jl34L12ozZFl83F4z4QJ7rNlVNgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Add the missing parameter and enum value descriptions reported by
scripts/kernel-doc when building with W=1:

  - get_relfile():           document @type
  - get_pxelinux_path():     document @pxefile_addr_r
  - enum lex_state:          document L_NORMAL, L_KEYWORD, L_SLITERAL
  - get_token():             document @t and @state

No functional change.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/pxe_utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8c1310dabeb7..f856a2fc1430 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -95,6 +95,7 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len)
  * @ctx: PXE context
  * @file_path: File path to read (relative to the PXE file)
  * @file_addr: Address to load file to
+ * @type: Image type used to record the loaded file in the bootflow
  * @filesizep: If not NULL, returns the file size in bytes
  * Returns 1 for success, or < 0 on error
  */
@@ -162,6 +163,7 @@ int get_pxe_file(struct pxe_context *ctx, const char *file_path,
  *
  * @ctx: PXE context
  * @file: Filename to process (relative to pxelinux.cfg/)
+ * @pxefile_addr_r: Address to load the file to
  * Returns 1 for success, -ENAMETOOLONG if the resulting path is too long.
  *	or other value < 0 on other error
  */
@@ -914,6 +916,13 @@ static const struct token keywords[] = {
  * Since pxe(linux) files don't have a token to identify the start of a
  * literal, we have to keep track of when we're in a state where a literal is
  * expected vs when we're in a state a keyword is expected.
+ *
+ * @L_NORMAL: Outside any specific lexical context; whitespace is skipped
+ *	and the next non-blank token determines what is read
+ * @L_KEYWORD: A keyword is expected; the next word is matched against the
+ *	keyword table and tagged with the matching token type
+ * @L_SLITERAL: A string literal is expected; characters are read up to the
+ *	end of the line
  */
 enum lex_state {
 	L_NORMAL = 0,
@@ -1018,6 +1027,9 @@ static void get_keyword(struct token *t)
  *
  * @p: Points to a pointer to the current position in the input being processed.
  *	Updated to point at the first character after the current token
+ * @t: Token to populate with the type and value of what was read
+ * @state: Current lexer state, controlling whether a keyword or a string
+ *	literal is expected next
  */
 static void get_token(char **p, struct token *t, enum lex_state state)
 {

-- 
2.54.0

