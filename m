Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F54CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0F4838AE;
	Fri, 24 Oct 2025 21:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f+akmBOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D36838D2; Fri, 24 Oct 2025 21:55:16 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA36583678
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c284d4867eso773541a34.3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335713; x=1761940513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CS059x6JwYd0Fate9jds1ZLvweIE2pEOBAhvAAGm0Z0=;
 b=f+akmBOvajjzmelat0xiiV4QcDr8L359BD7F/FC5TE4WIODboQwbyqwVkbMBPgTT08
 +//Z3lWBXk1HmroZHxazpGm6J8cy675Asv9LCzwiUd2WBTfNTV4tT6W52c4nq4FBDKfv
 rYOpl8LpQAKimUNfqQW0OBdXBBJZA7n8HFo64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335713; x=1761940513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CS059x6JwYd0Fate9jds1ZLvweIE2pEOBAhvAAGm0Z0=;
 b=wUcNhgj279HMP2Z7V8nlo/i/6+vIgKIpfiwj7k3uekjNy+piVpo4hJZ3aZTwNTM7G6
 Es9bZsz5jK2Bln9bUSndc5PHNyxnJp4kf9957+N/BqpCilwQLlVITeV29E2SLJpowqAu
 rOAW+/TGTyYfWi+nO/ws2ZYAquCgFwmitDwvKGfA3lK68WANrZ3ucEaKIUg3Nu+xgts4
 YxwLh0PgfvYc/qvXscA9j7pL6I1PWTQPFhd8X3VQ4hLc3vIpTqy1pFl59+G1nDHptsWw
 dn7rhhoAWpMBbblC2gE9aCscGd51RDqltGlMyGZSRWDA6H8psGqgUGbaEtY9ImUA6RMZ
 SqzQ==
X-Gm-Message-State: AOJu0YyrSakdYEAU2J2UZdr264fhGLPEYUhM8klYjbt6jhrmL638NkgW
 7xZKOhLMtNmp5HYkLC5BZBkZTdQ3JgJHnf87nJiPSHkwpkpZM1iEzccGiFcTHPkp6Vd4qzFO6+0
 Etq0gzTikJQ==
X-Gm-Gg: ASbGncuTd38k/t2fThdHd4KAbnSpEahWJST9Nk+6oYtZH65casBPFt2YRlkQaYq0k9E
 +6URgWfv4yhKriYBSnKNOx2U++0DiMjmED/5Z/FzbBepooRL8rf4LxJk5CYbtZZ4WmLh2WfOjrw
 tQUhOxw+EV53fSZxF+74gUq1YGzmeWdnuFcRLHW91hsedkkzhbZ6EUsELDrqaLrCi0QGPtE0Xpc
 kWBFmNPsgh+pWWunO3ba1XH25nJAqTnIfJO6yB7i5BsK+CZK5s1DZPo0u+Qle60vyN4P9l4KYkf
 lc6PB02eBs6SdEGD1aro4b75PBCu9N6rLStUXNJYNp0uRZsRbFsFDv1KK01LJ1lXc6m56pvjYDy
 B9+2id081zowJuIBscjYRnT/TqYEId+ZEnopI1+ukSYu7TX9p24PPunzuzugHIG0FeeODbcVhc6
 WM/qqEhpvL4kXI72nJXCI1iof7NoAiE2FrbCWVBreFrAxC6RTP
X-Google-Smtp-Source: AGHT+IHTCXmRG+QNOgrcyLGqisUvUuebtDXMy4+56HXZTzfsjhNKu8RbnS5p2VcNMu3YZjsVSF1Gcg==
X-Received: by 2002:a05:6808:1b14:b0:439:af0a:dc8d with SMTP id
 5614622812f47-443a30b1361mr13748265b6e.38.1761335713428; 
 Fri, 24 Oct 2025 12:55:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
References: <20251017-scmi-lmm-v1-0-9fd41e7a5ac0@nxp.com>
Subject: Re: [PATCH 0/5] firmware: scmi: Support SCMI LMM/CPU protocol for
 i.MX95
Message-Id: <176133571244.2586772.8038819873349316420.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 17 Oct 2025 17:32:29 +0800, Peng Fan (OSS) wrote:

> i.MX95 System Manager(SM) implements Logical Machine Management(LMM) and
> CPU protocol to manage Logical Machine(LM) and CPUs(eg, M7).
> 
> To manage M7 in a separate LM or in same LM as U-Boot/Linux itself. LMM APIs
> and CPU APIs are needed.
> 
> When M7 is in LM 'lm-m7', and this LM is managable by 'uboot-lm',
> U-Boot could use LMM_BOOT, LMM_SHUTDOWN and etc to manage 'lm-m7'.
> 
> [...]

Applied to u-boot/master, thanks!

[1/5] firmware: scmi: Conditionally compile protocol support
      commit: 251dd6bf0e89a587710fa7bfa320088617f8854e
[2/5] firmware: scmi: Cleanup the SCMI MISC ID
      commit: d1f1c98d8468f5f76c2c8c3acb31f83d736d34ce
[3/5] firmware: scmi: Support probe vendor ID 0x80 and 0x82
      commit: 7830ccc77a13dd2a9880a942734bb5687416c4d8
[4/5] firmware: scmi: Add i.MX95 SCMI LMM protocol driver
      commit: 3f20ea3675c466ab16761c9b280e6c382bae02c3
[5/5] firmware: scmi: Add i.MX95 SCMI CPU Protocol
      commit: ac9b02dd1028d14b6326970c93dfc3c50daa16f1
-- 
Tom


