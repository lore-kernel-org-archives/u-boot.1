Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD97606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jFbbreHI;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JIHkB0ct
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 594EF809A7;
	Fri, 30 Oct 2026 12:28:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qWtM5LvFEpDu; Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89898807EB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363319;
	b=bQxyHtbCeqrwL4B0eI/+RQEf09r0IRgS5GfnmxAvRdgzlqJI1iKr9buT5IMqG6QYJUoJ
	 1PIYQRlAN9eNXmvQ6XEGyCtBEXDjZPfjyyT+VKnpVfwxjvICEe01lSmMusN0UR4+VQVhj
	 XlflYY5fjcHaYzPsDb0Cs4ZrXRs9IaF3iqzOzIxIFCkdjyHrbyDQUk2cqOG2r8DpYDl2F
	 EtpdE6ax/oTF4s46lHjoiY5I47tCbe1PISkZ7Xn16URqziprUDIvd1AqxIt2CBeL3Fxet
	 piNMxviiPZqfr2IdQYz9f+gby8ckxVBvnLSN18Pgkzg4/Je5gaGFKunOLHW7Dq4S+PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GDwwVo6PQXrDk2Aan6bEQ6z4IcojUCxA328/MacHc2E=;
	b=M0JRdqIrZfAY4kLELcLK7di8VxoLv+PRpHxYutZkBnSDCTtuHR6DM/ltsifMH2gyvBc1
	 p2Plz2mbEm5Hz/3kCfm6njySbdl8wpFb0Xh3SgK+++xfasw+LY4i1yvh6Clg+nogMYTxn
	 pFnzo0qPhjLYVoJDN1sPaInzQPMoIYB5NzsZtsrGlon4YX+JeYe8+l1bzpf6cAGMS9kSm
	 5w8eDKo+DADEHBtDCwpUVdkS3y3XzVw826OzVxO4Lqjz9hbk4BKBRa80olQy1nHhJMWhn
	 Ru/UdIZmDUMZE5Xg3+3asL2LDi7psEarP2pKDfFn8cSk7TjDCpkr8KJ6fhWJXRZCNXw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363319;
	bh=GDwwVo6PQXrDk2Aan6bEQ6z4IcojUCxA328/MacHc2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jFbbreHIVgT9RrKY7jquia0DnH/jJuoeiy/vW5uAQDhsRghMGIqWbgYLBdyagjR0j
	 lY8ffOIWdTqD2GEoY5hIL28nw9/DWrke1EHpMtewlKP3NJ/s8B0qLEwv1L1mkVC2SH
	 qGtwPZXdzYcXpk53wL1349Fowue/gdcVR81cqhcoZhTPpxP6yFaYQ4KMqKRTez9GzN
	 /lKGNrjlZmHItEIOVTEASwIi9xJCqB3CqFYMLnF9WtmqNukWN1H5pWPyH37uozcsLt
	 H1OkFHq4dXsVy8Ls0YdMcLG82BTNR/fxmCNr/Gwxh653Jc5hxNh4Ft9bX4mNvXR7Wo
	 lyK+YDRD1ms4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89898807EB;
	Fri, 30 Oct 2026 12:28:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 862DB4BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B708607A0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQIhSFPgc-Fm for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 749F360679
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363316;
 b=lTcfv8Avks24ebSDQX3WZzewv7chl2w+tI55BSAE6Fqs+7fXOrDtPwMjCXHa0FlZa4k1
 6C5nSgmt/iTFKi2fH0FD9uBSgP78f7kt/XzN8D8QNfP9lCDVo3QySCDxBjoC45iiFKl6a
 GFyU7O2MlQKE8f3tfS1PKBB7lZXf4QmmLJbCwnFa89dCFKriK4kIwDgYx8/JocfxkzI9Y
 Y+lTOqoyY0THgM7Ugm108HBvmKqMjnSnB4nxL9zYOcNtr6m0TdVbmIAk4t7wqRdMyzNYF
 cnWGeP17qjop9bjagZ7jlxxv1ijNDpHtW8y9lnFF+GtVdvGxkHToBfWB4p2nmJrbicQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363316;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=GDwwVo6PQXrDk2Aan6bEQ6z4IcojUCxA328/MacHc2E=;
 b=osEeVDabvSUI2IgqdCQbKaejGtKVt+zwamOyVbXtyThVcqoZtYdRF7JdhUdarDhXYYOF
 +/UGXbuaJCkzgxszZP/X/hcgTDEDqRY8en32T+IBy/nAlrQU9D6PAtQ+Q7336pHrEHd0d
 I9bXPXbAIkTx8ANewJRzZJr1RGLsU39LUi6A4YFFjOkdE8CqZUHSauW+fbBjShc3p0noA
 EtKoAD4DeKhUA0f5D3gFOz/yUlQN4Z86TzE2v1dTr89yvjAEM/VKo/CiX1ulVwETDJ46x
 IoN8am8Yl5XYrEgOjRK4H7P+hEs+4e4nSn4MMrP3hjjCAkssR9s5qQZeVjDeuub+Hlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JIHkB0ct; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JIHkB0ct
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 749F360679
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:35 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so2821905e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363314; x=1793968114;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GDwwVo6PQXrDk2Aan6bEQ6z4IcojUCxA328/MacHc2E=;
 b=JIHkB0ctf3sgcBJ4ohXLHHdGRYBGBauzNPeCfZj13vzedpmfukH02/AUXRD55SlVMj
 c9wfuCh0hhdGLqgBNXZiFeh1fiC/evBaswrm6BQgJkPmnFsE+4Qw4PVB78kjyB5pq/8A
 Dxac6Vk0f1VM8yofzEyyKDuBnjQieTCuASXTDEzEShC4Ld4Zlr1KY2GpMWgFNtANmlJn
 54E9OR9ArpUOftooHnXIPoUtCqjQPyRbvvXSPK+PSpYcCDqaHZCcpkwDyZurdOPnVGXU
 mSykqjKN9sLIQ1dRuP2mc0v+XTRCrq4T82tqkrv+c/TQa0BDV+weP1gqTuLvuNJGONIW
 DoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363314; x=1793968114;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GDwwVo6PQXrDk2Aan6bEQ6z4IcojUCxA328/MacHc2E=;
 b=XdwdC4dcvNj8U6Y8mtU541/4PkA8nFhBBA0Fr9J6MrKbICgLm0XoxzbJT9e9REvMdv
 Ddan3+iVKJHiYCHLtF2r2JizEU6ozZvrefPWyNtamgD6uuRUWwZHG3TUmQ1M+qTJ1jn5
 l03Vg0MKKWK107MzHO0RLx+Cm3HNWBhDDB5QSbQJOpdJxK0NAgylA3vjzuKM95Hc7BjK
 hPf1PUtZo30WY0AKRrUSsLWvmVHhdeULoXwkAoaZrd4rKB4rq2amRwqWl/OW06zeP2Aw
 1v4tUUfP1txNYzqDyx8AKWONYbHqEXgTA9zgVGOW/7O3pwA21/PpFRd4nLfr/ql1IJup
 pJog==
X-Gm-Message-State: AFq9FYJsgySbGs22kRcEDu1Aui/zXvNCwHYNNET8jHKzf2M+QLuU6d49
 ACddZjLCmIftqC8NO98Cihd58Q0Nez+8tvwA41yFP3cSESUU5VfGdi/ct81y7fZAL18=
X-Gm-Gg: AYBFou1V9cr3Ub2s4suptvx3XjEFoUcvdY7ZXrnoNtjv2TEO3XmP1vm4zhEIbZXpzW9
 781hXTZme2dpnpTbNcD65yLJ9OBXmzcTb3UN0lerVWd3P76cIDPT2e/Llkz1u1Dnnwqx/S8bKuz
 /V/IFxJsaMRCF8l1r7IVdhyo61x5a+46HlDwMwcYmUqCgK5rCDLbzXt5+im0MhxTyhmakFxIyTI
 AStz5YtI7kpCf9itiwZ9V42ruNaN9y2j/SCFkUMXxiIaki1v5SA0Amvfg2iFnQg2HZQFiGxiuGt
 TaV2+PrtkEc5teZH2KLkJnIWBsuspInCTTkK00jXNeJE7v/ym76dgQzZMY9DBd6Dc0/lS6ioAQz
 tnI5ZgJoW/jvHQ9FhP4EO605GTgiV+cTMBkHR/WwlaEbjcia3U3uzq1j2nxrnjRzNbouc63AnUf
 Uz0npHWXICQZV9AaGuPiumDg5mqATHLGfO905wgwlw4ztTipNqkErq/noimd2uUbGaob2AW8dz/
 zr/Vs3Uj4Co74PkjSoM8MwRlaxtB9f/e7P1c/SgoCnedu++z5sqRU7EuH1b9BupYpLBa/l/rlwa
 h4ck54U/wiDsPtAv6Xn/PpcZqS+O5dux6SXdl9zcg0UEiQ==
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr45738715e9.23.1793363314093; 
 Fri, 30 Oct 2026 05:28:34 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:33 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:40 +0100
Subject: [PATCH v3 1/6] arm: mach-k3: common: add helper to wait for TIFS
 initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-1-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; i=msp@baylibre.com;
 h=from:subject:message-id; bh=mHK2/ce4bQoRGSTlKnAbM7Urms2sKQg/pd5no9xbz0k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvUHXDBact/Ys2C7Z2lqlVHTrg6N5yuL2te+WMlrVp
 4su9orumMjCIMbFYCmmyNKZGJr2X37nseRFyzbDzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBMdb8iI8Pv4x8e+J+I8lPiU7abtGKhvVLL7Qnv5Z522lqGBgdWilxhZPgzadXBSkv
 LRwqHtu+S973qOiUtMv6xP2vd4o5MM9M9S9kB
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a helper to wait for TIFS initialization to be finished. Effectively
this is just a call to get_ti_sci_handle() but I think a separate
function makes the purpose of this call better visible.

get_ti_sci_handle() internally leads to fetching the TIFS version with a
message and response. TIFS only responds once initialization finished.
If a response is not received get_ti_sci_handle() returns after a
timeout.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 10 ++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 6e382efdb3be..480c90cfa65f 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -54,6 +54,16 @@ struct ti_sci_handle *get_ti_sci_handle(void)
 	return (struct ti_sci_handle *)ti_sci_get_handle_from_sysfw(dev);
 }
 
+void k3_sysfw_wait_ready(void)
+{
+	/*
+	 * Wait for TIFS initialization to finish. This helper is used to make
+	 * sure TIFS removed the firewall before U-Boot tries to unlock CTRL_MMR
+	 * registers and continues the boot.
+	 */
+	get_ti_sci_handle();
+}
+
 void k3_sysfw_print_ver(void)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 37ff98d89924..146b986febc6 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
 int remove_fwl_region(struct fwl_data *fwl);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
+void k3_sysfw_wait_ready(void);
 void k3_sysfw_print_ver(void);
 void k3_dm_print_ver(void);
 void spl_enable_cache(void);

-- 
2.56.0

