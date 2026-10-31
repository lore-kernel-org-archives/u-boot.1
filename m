Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v0FjxUsL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBZ1SbvP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7504810F4;
	Sat, 31 Oct 2026 12:22:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8fDrg3p1vQh; Sat, 31 Oct 2026 12:22:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25567810F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793449339;
	b=KUNppgLtz2rDSJmbxolpS8s69UaPIRkb+XyF3eF4EcHUJmr1NkCZdtl/tBAn8vO/C8ov
	 vDgGpYGlIwhF9CNHC+Kp6SYLjRD1uaY8KhbMOjOywxtUhk6a06JUCRLciP7XuNegpF4dH
	 RMpQeAz+COBl/lOEnsN9mFCjy5XKXaqX0M0jeoi6wWiTge69OxhYnOWEvSAf9cF1yjEF4
	 gzIneEE001dEst2q0mLCQ1Zxp653KzTVoAekNEYYvcvj1P9jsAS2dzCgyBBbuzdrzsroI
	 08aUY3qof91f3S1GPvyIzCcJEXgS04jYyA3MT5OUz7weRzXZpIjn0iviK/Afje/I3Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793449339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	b=PtwDbEcUy1U7UdE4gJhKzcvcwddvsirKHS9fINsvblZyQVSD129AORi+oC4hykTzNz6o
	 las6Kbryi9WhaWwRaYxpvldMarar9YRkwKhpemS43+D4RAG974GgYlfwHH5F/DB8lgzkl
	 3Yhx5YwqblWUSDapJO7zCPbVf6S/gSq9n+5wI0uJ5B58dV/dx0o0FcTcz7XnqDQjLK6bC
	 4nH7KID+qR2yIU8aKxGri7A3//15OsMiprj7u16Ew4SWO6dH9d8cxZjphE0v8IMbR3nS6
	 2ANAlMuWhCTnAh6oZLdBblWTHbeWCqXINe0RdM1AY7RaosLsI/ONxqC68WzyA+imFtQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793449339;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v0FjxUsLmQg2vUtf68kxYEsCQbYjxr7OgPjygExm2Xycc8KtXE7Azc3kV9UVgLWtM
	 dCFWqZ+7GsYJB7h7scGKla1vL/2gjJ8UQC9esYKkRpTgoVNUC+t6coIABZLUTpmqIl
	 fBzryYu7A7HRRiskjlQpWi7ojaC5BPl5Z6RkQE79f6kba307Xu+15F2/K8JC0SHQQ9
	 MBZAKiRozFbTikGfRHkwxqn8R0XA4vpA9CiVauuRTc9umpt1hbC3yhH7153bS2p7lN
	 f0B8PlYBGJMIBXpjZ+Tx8ZDiTxzUty+UhiY8Rq9GHXvn/FHm6oFczV/3Zr57AZwsNd
	 QvAXvcwDLW4GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25567810F7;
	Sat, 31 Oct 2026 12:22:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 31B35380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1402E40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y5J3b0_DB9uf for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 12:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6859A40049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793449337;
 b=kXtwP2C+fLw6GXk/RdZG61SShV7qmtoAJqTGKRal6VHBeJRa7yU6gcIZXCapbEqeZI1K
 X0PKLNXnGyuFkOrDvk+QTnTQHp36LfUFber6DQEigdlqd+PPCLMJtR53ANNQAeEKvuh7Z
 c6tDSjZ9MSO3iB8jn8BYPRA0nuJuWBfjXGWKJuwbX4gdMX7G3KXASarra/CRX/3tktoSG
 8M5JDeZNs2iMbEu4VlVvdQdxAy+84FkaJLiCNMn/sl4zSSerbnLRCWQ6yFCuXxTEjXolc
 F12HLv95u3Jho37F1U0fh/fYjL4cXKf8uGK7/I9/Ad0lKjy+PxXQx+TQ4qtpdjTtDdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793449337;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=dgV0c3ymPHCa8wIPRsNkhWNRncBvkXlca2OKeCfzDJ74d7CqB2ZtlT+ZD4VowWt1a0f5
 O6k6OMPwy6s/zhqIL2fRI4GW7IPzZpMoq57BfTQjMzxd+BDGXUxeU3k9w/oqly9qOeAOc
 ovbb1w74XUoXbEpCY8KpiYqtkM4swXNuiR1RU5JdMy53DxpwAP5DGxAxcQC4ndyUsHv3s
 IJL7dtp1btzO8B0K7wNoT/cLAHv46HDL4e7A2U6g+3lt9px0GunjZB/BAPKtfx65RzthP
 meEbKctAbMKIR4LZyDK3hViUiX0JdkPpIN38fUS8P5YbGMD3tNBji1d/aPmC6cLG8bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=KBZ1SbvP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KBZ1SbvP
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6859A40049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:22:16 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso9372855ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793449336; x=1794054136;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=KBZ1SbvPI5UXf5qHdKD7RLsBb8o3Lpq5qfY+OJnY8yMm4X3Zl/fnXBUxV+Mf2/Jsnu
 fWyGZ4fc85nXiNUMVwpECH8m6snPp+fePVxx1zgYrZtZamjmSdgVxROX72kvFNtnOOlN
 ceCCvU3aqnsC/H9Sm5XgcRIpmdZ+hMMxc89IAYs9yftr7qrG5kFV8ef1aQMt3r99Q18k
 5EXCcyRrbB+f3m1o9v1vZOQ36y4a1jteqK9ikccfWJY7ia2jFCi9SPjOroc7Su/z/VTf
 67GtBu62v0oIZcSA1pPJDO8ez0QlASUQHe/eMZe1xKLkgOi6GFCnS6BoP1/ba+QGZIo3
 kXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793449336; x=1794054136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=npexYY5JTOR9E8gEvuTWaIGxUSZpHmlHpKBgLZ4O5QtiVC4tNUF8xluvwQXz7jjaeF
 8meod8AST7MohYDVVnmIerl+dAP5hHmRs3cWV2izDH/xQjWbAUhGXC8nFGbK4QbMrkWA
 GsZU+dT0hlJ32much8i1dDCu3y33BEh/6Y9BJy1NK34nLxjkRjAb6gdCvjJPWwIVjajJ
 t/Y/S65733asopA2P5SaGOmF7XNElac/KeZib/mVmZlc/oq8qsuwi1j3NAfAhwSqg1LX
 ogcVtrnYfH7UgJI/dGFdP+NtPz5IiHFDT86oJk++MHsMdwjDvGkOMxqClplHnI8DtIxo
 AOdA==
X-Gm-Message-State: AFq9FYI8ohsTh7QFaxz6WlaPVP1VUkDWPE2EaxQXuzpar6sIS1q7T/xE
 WsxXIHRTTFZsIbgnvycsdJe1JzwuTmQxvGwf2R/eVG1KSWR7AnnCDWen
X-Gm-Gg: AYBFou09yArCoe8pPVyEBsiDrhA9W6oeC9khn1/aonimt6y3aYAHcNyMi2lzHUXNN6s
 Utw2LKKNCH6JU1mYy4m9fnVIzLI4f17D9Nsy7BbjQ8HtFw42gp/hnN1GqI5Xzc3kQoLRfPKqy5F
 aI7ji9tFHD6n7kh1fKKVz08FkKtWjiDJlKha6SjZ/RCjLCnYTR5HnbTLTOFcV1zj0uKcK0BoxGk
 32VcV0WuoR0cyWpKw3vE+bFu5Xki7TY2f7pD0ErutSXKACspUfuEVBT8SjPAQZERl0v5TC37TeA
 hVR7QeIO8HKd89SSN25zW0WzT862agpps8Sd3KTqvEhrVWwM8l1Fk4NHr+keqARfbvMEMTTsVUx
 hOdeRy+S46Be+HKOm5rI7X9r6azmULeerNwVDzLoEMbQYPh/JLW5TZ1qSiQ2khjHRn1PZu2APyw
 /6hmYIq/8GpjU++Vf2BUksgrwDl6IyuXXbpRaNf29IY0jHfU6D/qMaVk7Gy5xVqld8j357041+A
 XN4HkwgAYdRzaHEo03XW/P0vtiUF97eSTwZTU9mJcWiuEUam1EBZMAWsl31zuKcl95QgBVuEWa7
 eeb3zQoohFNPjoOLlrpyNORDlq2NEh/ZRFkcctklG7ePrgNRNqjZ/ZM3dEeGyBIXY5L0o26g5eI
 AO0VAEAQupmbCHjiqeasumT1h27H+g95HpSIhWC0nJk0fDH63ewswQSkdLArZirEDw4LPRlgJM5
 icsITWNtSUe0tbT91BgUrDpM6E3O09Fw==
X-Received: by 2002:a17:903:390d:b0:2e2:dd98:59e8 with SMTP id
 d9443c01a7336-2eb36395c06mr47707395ad.3.1793449336250; 
 Sat, 31 Oct 2026 05:22:16 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392ba7d3sm15472875ad.75.2026.10.31.05.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:22:15 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 visitorckw@gmail.com, xypron.glpk@gmx.de
Subject: [PATCH] doc: virtio: Explain how to reach the virtio RTC
Date: Sat, 31 Oct 2026 20:22:10 +0800
Message-ID: <20261031122210.3237663-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
References: <20261028102343.1747940-1-alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The date command only uses RTC sequence 0. On the ARM and RISC-V virt
machines that is the PL031 or Goldfish RTC, so date never reads the
virtio RTC unless that driver is disabled. rtc dev does not help, as
rtc read reads raw registers, which the virtio RTC does not have.

Say this in the virtio documentation, and that x86 needs DM_RTC.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
This is the follow-up Simon suggested on v5. It applies on top of the
v5 series.

In my reply to the v5 cover letter I said the doc would point to
"rtc dev" and "rtc read". That was wrong: "rtc dev 1" selects the
virtio RTC, but "rtc read" then fails with -ENOSYS, as the driver
has no register access.

 doc/develop/driver-model/virtio.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 30df0e944..94d3dabbd 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -81,6 +81,14 @@ on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.
 The VirtIO RTC device (``-device virtio-rtc-pci`` or
 ``-device virtio-rtc-device``) requires QEMU v11.1.0+.
 
+The ``date`` command only uses RTC sequence 0. The ARM and RISC-V ``virt``
+machines also have a PL031 or Goldfish RTC, which gets sequence 0, so
+``date`` reads the VirtIO RTC there only if ``CONFIG_RTC_PL031`` or
+``CONFIG_RTC_GOLDFISH`` is disabled. ``rtc list`` shows the sequence numbers.
+``rtc dev`` does not help, as ``rtc read`` reads raw registers, which the
+VirtIO RTC does not have. On x86, ``CONFIG_DM_RTC`` must be enabled for the
+driver to be built.
+
 Testing
 -------
 The following QEMU command line is used to get U-Boot up and running with
-- 
2.43.0

