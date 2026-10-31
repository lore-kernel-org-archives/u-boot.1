Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZfvGT2dg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/fhV/0p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDBF080E4C;
	Sat, 31 Oct 2026 12:09:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aOj15nhnHlLk; Sat, 31 Oct 2026 12:09:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD2B380E14
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793448543;
	b=KJ9OlyraEFgwAYd+2pbz9vLj9QI0h3tKqT0Hq8jwL36sUfZm3XfL1+puSo6M64hLrEC/
	 n4/anEldnFoZvPHItu6RXHn8W66CXd7FhSrjebHXdznOtui+N6VNgXe9ehAHVyvfIoq8v
	 GuTHBxGf2/U55/k49q7WWipIaYlYuNcBLwWQHLWQ9Jmcq5gXr6iE5nMjc0JYelZDMeJB3
	 OfoTdr9a2yqbTlfxs0A10aYYjY6/ERt6FL7+ITUjHbPDAMVp6/eqAYuzv61cyho5F8ViK
	 pPk2O6Ar4ctRUZaH95SDrDMpNE5NEWff8O4yR+zw8m6j/xiUwKNNqTaaqAMGbBWiNUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793448543;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	b=G4xa5wPufvhlaMhdQXpVMhenFdLuQhGVI/38ZL8smFpGnRT2Rvk2nyWG3G3NBWGt5PY7
	 5TREbOkz7xPOQztzaaF/fZ4jQIZSoUWJ87r4lxClct8xoXn3bgiN1e+v1t1vTQffwJGkS
	 P52w+w/4Emm4nD5LoM5vYwXm1YbQ3qZhaz+BGBxEb6O2ZXgyBSEPfje/0/9eVr5EI173k
	 xOewe37z3W/wyuS7whe9m5b6se9PuRekkKzFhhRrTuVdKRHUzKblCWghAda9e3xc5NaIH
	 6IFt/5b4BnoV8YoNOx10GxC+uDvlZY5Dj89+N3LtMUTQ/jkhVO6uXGvdZyB7ihXGoIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/fhV/0p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793448543;
	bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfvGT2dgDl5oTuL3DvO75CEAPYZpsTYSYmR8c5BMmPnjnqf+/2knon/tG3v5anw4T
	 YtLaeJekrWWwRNwImXAzPXnn9fak2EE6lbHDRBX5SHeVhu4hPL3Ts6alTvJhThkQpf
	 hEab8q0VCd3Vo+T/IyCAT7kULMEjJa2BtZAXSxchAhWYl3uwpxbzaByOwhwP6hbRP8
	 aGfxOxfwjyfb8VE22glstrAqYvspo7eiNkhdzZlJrfd5C8uRgzYeFhUZnoD6JdY3YF
	 Env5apXQxMd13FxwnRgRdIYZFTGQ2wJa3wtv4VChGUsxM2NI5+8FILWmuYvEpIRGb2
	 eFsOsFfFvqxXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD2B380E14;
	Sat, 31 Oct 2026 12:09:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A49F1380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9615580D6A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwTeTA4hSPj6 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 12:09:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F310680D44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793448540;
 b=jnf+OHYZPUip3UFpZJUldHQk7NwHlXs8cK0rvMq4X9CS9+0sqXHORrMUEgzZknDOfbY+
 L7kxs7WroitdWYfbbCMThrhW6saRL9+atvyXaCpT+eSqAZAuvj3uorbg3DOCNVU5A2muk
 CyUVX66epEwtoiwsR3IC7K+jl4wpy5iDez8Wftdc6GAh+wEQ/BNj1jZyjq91h1mC0bZLU
 c+TbZaCrmty6XP2QQkaV7PrkjeW3ndTlHIOE/z0uHv/BA9Y3agfZJzkdypkKCIt1rdJm+
 FJJA0itXzNVCiStaKWlusklDAjnT7jVY65ScjDeQXm/M53NQOt41ktff4VQ/JuPwh5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793448540;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=Lp6JrQNECRMZlLsiPzVYp9TGq5OIx2pPeZgF0usIunPDMRuSkRBd5yFO57GE0FlOszzf
 II/CWZKnuJntRZFx5SdKUayCF5DO+v98NCfdMm/FlHWRv8K9N2O2IByKldWvyKn1UylMA
 t36a++4+HxLIbB7uH8ywARNUhTA4FHasFqMhJXNqsPGPMJG3mrIwRu4JFI+OJzwxEHUbx
 1kQ/EZ4T54ikRgdMeM1AUHvsUsjxKolT8zw1FfWhlMhGrWXkKanZ/Ll8eTrAPIfeWMe8r
 uv6s1B0KKbypODd1br3sVrZ7lvNUILh8cNtIj4y0gmlpeKSqv32zvY2cbbx1Xvh9x2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="x/fhV/0p"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=x/fhV/0p
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F310680D44
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:08:59 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so1193654a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793448538; x=1794053338;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=x/fhV/0pge+1joR76IyfzLxU0UfI+69pDphsu7lwKm86Rd7oNcHEBkFDHn2Us8fLfu
 8uo0jZ6k/7mSWWe6HHuO94nqsDVuetIEKuc3qEiIq1WxZ4tTzDZ4/HOXZP7ycUlYIyyM
 EpuhczzmP7y+uQWVQ8ffDxFV1e9OVVNjni81yHmTiDNnSi16zpn6wwi0wiaacTji/Qp2
 a3i0r+Fdodi91fTMPXjiGWxIfj7TNUD2usRMNlw/5iCbEQp01TZVWz2xCoMFFBKis4H9
 kl+HZAEDmaLK0yAg/AH8+QbSmo4aid2BAEXpSmnoRyciDCGtKTbBrOc1j4dQkAp6bsoc
 vqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793448538; x=1794053338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nknIhTQlaIhRAYJU3CB5jE7Z3He1Ku916GtW66yynDM=;
 b=wTGb3c/645GyHGR+FKemC3gqQ9RV/fwNs6dcQcqOifinDraITdVBj6n1dveTbUzcAy
 30Q+jcgr6XN81ifDMkLtZYgI5xgt34lHv5iZ1PGhNn5i2fS9M/fbKISZyW9W+Sk/49y1
 kNMHG0rOa6uOVSVFn0ZY/1b8MlWhbOJrnXJ9GGAhitig/Zh/R+H+Nqjxzvcf7MWdE/aC
 472NM7xjXETRYlXTsCiUN3RIyvQhjD1aFEzudhfkLQhd0zHWywq5qCpzUTLy0Wyvx4eJ
 SR/4IvqN5Y+GWkryf8tXJcwOeOk+9QmNJW6P6V0o+cQj6c+b/Jm6U5K5FyDJc4owLNCk
 TbPQ==
X-Gm-Message-State: AFq9FYKrx8Iwur8YFr6UABMuSoFCMi6B7Q0NAcfWbwpjj5JUmfwIqDk5
 OTk/lKEoYrf5HBl/7WAyqmjRHFUoGvaPRqm1I2gJJktqHbtuEHH4Eyw4s1pesYdh
X-Gm-Gg: AYBFou0rzPktZ8n1nG2SdhB9TYpb58xJgXttIZNWPJAD8UpR+QYj30qu2277R10UYsd
 JZri0FnTsSWGhRnsn6rr8zk7W/aGfeG9ckbhbCRs1pW7asQcWs9m+G80HIGdMxnjSQNepcchddx
 j4aJIssDsNXniw4X3oH7baIqJJ8iqYUyc0Ere2qHiPIvj58WG6BjOtddzCzR0vSgWbYPcTI9300
 xbTzVw2bopHIEuhvTm9vcsxLr6ri8/Yzdm/mnS9ZB392QT1ERnNoCbJoPyBROw/7h7aezvoxLhM
 A9RmxQwncN/vfKoeyaNcH5c1AusKa3pXH9MEnq3J9kUJmJwbphtWWBpkKxC7aGrJ0SZ0BBo2Ry+
 prA4GK4BWCPQAldXQHOzgyUs7C950En4+F/l/yVAtro4/dUOaGrbXkdaB35DmqKhDFs+OLuRJIf
 Ng2n6wgJkiS9/UMzlxjFmqOUXZ+bGK5i7RKyzdCjnu88YYKoI6fHTpcOm3ba2K1OxeAxtslkxDN
 pHJbduWl7omN31zRGMSopPH2y8fZMJ9NfLldyxoPclYIUn5Pk0ClCRQ7Y+tAjitC+urw88q8t+b
 IG6ESzInCSmenXUMe+FShTc7Ni/dEnyHhwQ+H+RSEZ6xTte6/srITCu/zy/9InAVtxWTBYEMg7N
 5Kegva17TtxKZshtgDsnNzbC3b29sIid5S/wc+vd1HXL1++8x+j2y0NyAzhpU1jK5bLIIF2Wpuc
 iMZw9Wzznf
X-Received: by 2002:a17:90b:2ecc:b0:3ac:6fcf:91d2 with SMTP id
 98e67ed59e1d1-3ae897c64fbmr4184622a91.19.1793448538614; 
 Sat, 31 Oct 2026 05:08:58 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e8fba61sm11722642a91.6.2026.10.31.05.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:08:58 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 visitorckw@gmail.com, xypron.glpk@gmx.de
Subject: [PATCH] doc: virtio: Explain how to reach the virtio RTC
Date: Sat, 31 Oct 2026 20:08:53 +0800
Message-ID: <20261031120853.3229945-1-alan.tseng.cs@gmail.com>
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

