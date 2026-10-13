Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B1BCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A259680D48;
	Wed, 14 Oct 2026 04:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwyW2otbtQHw; Wed, 14 Oct 2026 04:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 860A080D39
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791952078;
	b=R/mt/mmYDoMS/XN84xnwUCRKpd7aljHjK0vFKyNUtnFg9EvzWOF8QClAxkAj48kJqOe9
	 e/xo3191LyeLj5tA4aFIV0gle4zUDI/9zRbnfqUO5cQllctkypCfT+SJxFNJE+mKOSDnH
	 gbGkucEa7tDV2L5GwJl3rSmXzJycXoSdWkHajXO3E11ixfreHMdj129jiM2zCz8qzJlZw
	 De+MYnNqi1MD3tFqYprTkx/wdWZJSUXOsSqefXYsDIeFNtJzwRihwwHRiFHp85tjTCr7u
	 xR0Q8DO3EpliN1vRrxybcZC1ZNvP6XePdQwrf0cPhrSnBMU0JIsEFzrfqOO/GHmeUMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791952078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NDqwgkJgoo/omrhqw5dqYQulCzcpenPSZeQ+gPXjQE4=;
	b=HuMhHkjEHc1yz7SJM1T6KaOMcrl9SbWQUPSeXl3sIwVmIksfCvAW7imr6aElRKRAyevB
	 M7DHYomjOZHDlOLooihwOOthqWG+bqeEQmBmB9VoE5OeBUOeDT8fDB4oCzYRUdFnPYHOj
	 fMTIaBeXpujnN95SKRNqMnR2qcZ2Mydc1ednEKQms5Rm6byvyBCr64Z3XSZ0VidspU3he
	 LDe2kPrsFYXeXphJfMDteIVJfVH12+YQOARXGWd9PELApRbeXOmrMTqsmYyS7xOKJtCdV
	 z7KN6Js39aHQKKm9q2vmcNPQL6nNGC6A18QNEAGceeRM1YG50gFZKxVf5O2ScPV1TuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791952078;
	bh=NDqwgkJgoo/omrhqw5dqYQulCzcpenPSZeQ+gPXjQE4=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JOzFYDxNQV73h95lKaI/eWqFFWolmHLgm5su0cmGhQ5Y2gO5KMKgkSfngHZCpNbx4
	 9OEQLMESEBLXxXKj1rmlG8sfFEsb+M+u+VmD9H0IFfikRjXx7qXTwEMDPzSeEti1g6
	 rUASx9UzoEmd8fz8FG0rZKc7cIuA1bKfNfgKENBjQ/ptJ8t1xJpnDtFj1DZDQuI1JO
	 c40CqYJdqdIkDSoeCMFjfmeZ7LHWJrLCu2Po+PW8/CK+aqqU6MMPbuo/W2cwZzIVp+
	 UUKmlCuH1HsnYyl0yxS1YuC5ZxlRnNWeJNCLp6FzeUqbCOBzoml/Yj/NiQWqGj8PZj
	 p4h+VayJsjx8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 860A080D39;
	Wed, 14 Oct 2026 04:27:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED2E52AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3A1F402E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yMnBW5WsyOTU for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AFFAE402DA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922575;
 b=iMPPWpWg1cifmlzXK42f2Ovm8424yXzUgSpu69f06t52FzWAuQWQO0f1FlN95Q8NzBSL
 b04KLbxIbkdKXcKxztbr7d7C+BElYSs+4ZOja/As5A5xVYh/BvgqxPPU/d/4MxYGpk3Cs
 PTMRrN/OQ947CbWAnV71n/D+2AIRceQu564dLW1GwxeRhbFq0RcONtH/eRVCpA7Zh6uY/
 mzNrNioBa/eEioRYZRjSzci/o5l6CPXtXav2Z9yAyAlhpGl17H9qqLTJonXvKUJIn9o+o
 8SQGkuofHOKqd0YOAOceqLKK+4Q9noKjEACDe+EMUEUuG2G0AL3eqwYw6hl+HUAMKVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922575;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
 Content-Type:Content-Transfer-Encoding;
 bh=NDqwgkJgoo/omrhqw5dqYQulCzcpenPSZeQ+gPXjQE4=;
 b=Jk1zWgHDC0++oHfoxXQZLRK8DEP70h2TUevrSNWCcaKh5Zp69XFnhrWNFPZri6ddNL9N
 N4WmQxHqsOxnlxlP6MRGLiy7gdDXGA8nZnI3DPEDOuLOLsmdY1kT5MlmmyajYP1/HVoHw
 B/h/OkTRQ1kTXl0xC+7cH4NPGJtjCk0DW+iI/q56zKiUGXfakIIE/AR8qg+9k6i7gRJHS
 rWXP7zshTWApotP9ZpzyuKfXAPevH8cI6kbxaUWVOFjoVv2gvphwZhAMFZzAn12GaI7u3
 nRzSPwe3gIi50AB55Xm5h1YUxd4LTcpVoL16QB9yw3pASHSQ7ynQq47UKmrtLJZBfwA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ST7hO6oC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=anon87111@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ST7hO6oC
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFFAE402DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:16:12 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so364327f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791922570; x=1792527370;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NDqwgkJgoo/omrhqw5dqYQulCzcpenPSZeQ+gPXjQE4=;
 b=ST7hO6oCScnSQevyGslUizkcBnE8AI/t1EKT1ZnrpVMLarDuaA5oeuGQtlKt7Or41D
 EFhyT1JJC7rY0KtVr5sTpKSz6ecuTZ4Z97wwX+T9BPCwIQ7/rgqbwsFo4OP95RFfzXYn
 yZlAJmFL1gys1KwhdPRHd3Vd9SruxjADym+/lgVZMCS+4fLSDLtY24tTzja67VFLvVLU
 Xrw96N3N8TYWAU7SOCvmy6MVyUk6yP6N75pVdreZEVGfXwWqBFwup6KarDtuMlsuxe8t
 fdM4Ext9clOj98hP74H1Ei+q+pi5K08ybcsjCBzlHtz//VWxJYEPwaWkhlZuY1sqiew+
 5zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922570; x=1792527370;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NDqwgkJgoo/omrhqw5dqYQulCzcpenPSZeQ+gPXjQE4=;
 b=oxTlQmguQi1MrvLyQ/sYNrF1MFKNfHaU1GJ7Wn+T+A6mJo24FTMhqjg1O2oPzITtNE
 yqUPdeuQQ9XxGHwEbZPH7nUtOSjJkd4mignH54bjIIpgRtN6sxnalDAGsnGxq+26ld0s
 mkIebeFhU8R8QoelfGFtscppCoGuEphBBr+Y//Al+FNrSAwWyeJN2eJ9VA22xlx3ahuL
 bzFzzhS+Q7JyxbAwnwyfGVay/bcr+eiSg4joBGrw3eTFi9IRZg+lzSitnvbWkQzpjj73
 mJzRbEAsNY+77y/ltsqoFOELmsHVvHTKcYzW6ezBWzseZ0nREs66H1eywJnWIZZFrNDf
 CN6w==
X-Gm-Message-State: AFq9FYKFfW9Ztjt6o8kkzc20+HQ4vtUBgdVfd5npYclW2aQ7xZ3gaUmc
 VtJT2vAxmzHASEj53TmmU7K2rD2PzuovDwQEsWjqa/4XHVMpsNKwfXVyzNdXbXrq
X-Gm-Gg: AYBFou2RPX7vGxB9AWqjj0cDATHQ6lqn2hGYEVBuSQnLdkZVtKHbxMSvlE+B7q0J7Np
 JCVW+e/KO1nodi5kNgmjVVpfpj5YupPcWQWda48nN4PDRegL2RJtpa7tmfNI2Vvz7WuYJus3Jko
 GOC38eD1cxgZqjbHlki/md8KRagV9bAHEHm0KRBi/ehwHyGpLj7cFuKcERpqh0vfzQW1hdrxReE
 YFlNybU82D08/cRSQQ49YhFpuJfdHl3DK2pOulKKACfAa9xCB8S4puX9D3x42sA4ViANZVVjjqq
 qWuD3/yE8vscP8HES4Y4n/LeGbtdKhSdYFztSB7gCtBMLuZt+5JAFf0eI3bC2+/b3hEOdZj5mym
 6okqsJtWBwM0q0DdIzWPEkPdonKbJXB7egU6yqoiVkmoxcvkhYR/NtcKsKV58smx1GMxs0d1gwn
 IDTKpijaRWs+/vlsGD5UDRQosYZ4vM3aLzBmeCOquDPm6LP4YM7OegAILKSEkhTyN4/b8udR2uE
 IHZo0nebHOxVKxnFwNY/hlRC6afufrEGStrUQUQzSb1eQ==
X-Received: by 2002:a05:6000:288a:b0:48a:f11e:6d57 with SMTP id
 ffacd0b85a97d-48dbaadb3a5mr24837082f8f.19.1791922570055; 
 Tue, 13 Oct 2026 13:16:10 -0700 (PDT)
Received: from ?IPV6:2001:7e8:c647:4001:7656:3cff:fedb:3af7?
 ([2001:7e8:c647:4001:7656:3cff:fedb:3af7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm1750868f8f.13.2026.10.13.13.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:16:09 -0700 (PDT)
Message-ID: <e4f97d42-fb3a-4c5f-8f11-90a87b2172f0@gmail.com>
Date: Tue, 13 Oct 2026 22:16:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, 0xiviel@gmail.com
From: anon87111 <anon87111@gmail.com>
Subject: [PATCH] image-fit-sig: bind a required image key to its own
 verification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 04:27:54 +0000
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

fit_image_verify_required_sigs() walks the keys in the control FDT, picks
out those whose "required" property is "image", and passes each key's node
offset to fit_image_verify_sig(). That function takes the offset as
key_offset and never uses it: it calls fit_image_check_sig() with
required_keynode hardcoded to -1, which both boot/image-fit-sig.c and
include/image.h document as "-1 then any signature will do".

With required_keynode == -1, rsa_verify() skips the "See if we must use a
particular key" branch, tries the key named by the FIT's own key-name-hint
property, and then falls through to "try each of the keys in turn". So
every required-key iteration is satisfied by any signature in the FIT that
verifies under any key in the control FDT, not by the key the iteration is
supposed to be checking.

Where two or more keys are marked required = "image", a single signature
from any one of them therefore satisfies the whole policy. Possession of
one required image key is enough to boot an arbitrary image, and the other
required keys contribute nothing. doc/usage/fit/signature.rst says of
"required": "this indicates that the key must be verified for the image /
configuration to be considered valid."

The configuration path in the same file does this correctly:
fit_config_verify_key() passes key_offset straight through to
fit_config_check_sig(), and fit_config_verify_required_keys() additionally
honours the required-mode "any"/"all" policy, defaulting to "all". The two
functions were written as a pair; only one binds the key.

Reproduced on sandbox at b871f722 with two keys marked required = "image"
and a FIT carrying only a dev signature:

  keys marked required = "image": 2        (key-dev, key-prod)
  FIT signatures present        : sha256,rsa2048:dev only

     Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev+ OK
  ## Transferring control to Linux (at address 000001cc)...
  sandbox: continuing, as we cannot run Linux

The doubled "dev+ dev+" is the defect: one dev signature satisfied both
iterations, including the one for key-prod. The same scenario against the
configuration gate, same keys and same default policy, correctly refuses:

     Verifying Hash Integrity ... sha256,rsa2048:dev+ sha256,rsa2048:dev-  error!
  Verification failed for 'conf-1' config node
  Failed to verify required signature 'key-prod'

With this patch the image gate refuses the same way, and the configuration
gate is unchanged.

The hardcoded -1 dates to 56518e7104 ("image: Support signing of images",
v2013.07), where fit_image_verify_sig() already took sig_offset without
using it. 99f844ba3a ("tools: Pass the key blob around") added key_blob
and left the -1 in place, in the same commit that kept key_offset wired up
on the configuration side. It has survived because nothing exercises it:
there is no required = "image" anywhere in the tree, and
test_required_key() builds only sign-configs-* fixtures, so the image gate
has never been run with more than one required key.

This is separate from, and complementary to, the fail-open gate reported
on the list on 2026-09-07 and patched in "[PATCH 0/2] image-fit-sig: close
the image-signature fail-open gate". That one is about a control FDT with
no /signature node at all; this one is about two keys being marked
required and one signature satisfying both. That fix leaves this behaviour
in place and this fix leaves that one in place, so both are needed. It is
also separate from "[PATCH v10 0/7] Improve FIT signature handling" [1],
which covers the configuration gate.

[1] https://lore.kernel.org/u-boot/20260923114940.349985-1-ludwig.nussel@siemens.com/

Signed-off-by: anon87111 <anon87111@gmail.com>
---
 boot/image-fit-sig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index c0fbe81b4..d6c61e104 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -159,7 +159,8 @@ static int fit_image_verify_sig(const void *fit, int image_noffset,
 		if (!strncmp(name, FIT_SIG_NODENAME,
 			     strlen(FIT_SIG_NODENAME))) {
 			ret = fit_image_check_sig(fit, noffset, data, size,
-						  key_blob, -1, &err_msg);
+						  key_blob, key_offset,
+						  &err_msg);
 			if (ret) {
 				puts("- ");
 			} else {
-- 
2.43.0
