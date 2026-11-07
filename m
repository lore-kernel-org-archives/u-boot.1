Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83388606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LrpPB8Ws;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EpVoZiQq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50996815DE;
	Sat,  7 Nov 2026 12:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1-fFJZFGvRo; Sat,  7 Nov 2026 12:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 336D6814F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055815;
	b=U0pMgiTWVQ3eH7a1Y1SOFCCFwdtGK35q1K/IeCR5Prm2Ud5rr1t1X8YE1K89NeC4NMr3
	 4q9I5ItJReVweuSnKzODzjCcBNxJkYSTLBrrdnvE8YiEPRWzS//zVVZDcEkRr38xCcoBm
	 NscQc+GmpvdS1XMjzjGx2VfjzzUTUiuFubFIOsgyH/zVgbbLls+ni4Kj1/ChhmQUscDfo
	 NT8Z/KpUnNZDXHSwXdLsxcgRH86qXl6H33kc7dyKREoxyMM2FocGdw4hd7phZJOuvzGFf
	 waRNF+ndpgpHWUAjzsKn3S6TmNtIojdc8Cl4k3uzB3IKbjrAHPxmQbezlkIUQmG3pIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BWhXXg9KugBk6j69su9gcUtst3e5rIB/0t0PjRsXRGc=;
	b=guh58/vCetr+5+fL4CAwLDaUqB18PFPXjWhE9k7ig9ED+BvctNsh9GxlbYlje3Wzfvzg
	 siJFKeWjZmD6MwYVETNmM2O5gnZHHqPSGFJqsOEvk/JYHPzi6ee+szM5u90UYy8kDGQ0J
	 V3ADZEXT5zdAkFGHuoKdcla0x9O12q/0wLz23HKuH+13/atXFJc82D6NSdQKia7lKO2Gr
	 hISQOOpnzo+TrK7OvY5OSEeIo+TSeZ+nYgR/QAcFdrJcmf/UV9ePkfQURjoo8IQzQ0jQX
	 TyogDdtmwxhAqFXYL9a6Mekr8ySMO4NAPoGfuD81QvfAgk9ir+sm1+zldHlOf4QwzMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055815;
	bh=BWhXXg9KugBk6j69su9gcUtst3e5rIB/0t0PjRsXRGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LrpPB8WsiWdUVhAdbzQ3qP4cH3QVfdhlFPM1bMoZrKdSyBcOgl5peqjpk5yFsJsxh
	 YzdFM9PK6Q4+Q+O5xAgtHFgU7IViF43vtpehM72Sq8pRPGp6YHdG/bcCeVCFJzoSwN
	 Cl9AIQDcSZDzuWwP7gPQVOTWwnH1dondLohFxx3lZ5or51W0tLDh6mtk+sucPUQ9Oc
	 3a0QC8FueVJ3LF9SdWr/53ma06P3aUJ/GLDDPBztZX7GSOMUzxxZ3CE4/DqxrPsWbF
	 8ohbO6kYCx/ML1/IvLkDt02gHYOP1YZxl9ZAqXaNZiOmU94LnfUpn2aJtLiDrSg/Gm
	 R+E7VrCWG8B5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 336D6814F1;
	Sat,  7 Nov 2026 12:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D6AF34D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82B17606BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GlaNvOJ9a1gI for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87E776069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EpVoZiQq
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87E776069B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:23:24 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b5869223e9so209546a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036202; x=1794641002;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWhXXg9KugBk6j69su9gcUtst3e5rIB/0t0PjRsXRGc=;
 b=EpVoZiQqR8/KMcZtC4rW8dV8L9mhqOT/s/M/U4SPP4bNEkH+18TfyM8exOR2tITZcc
 JezyPLaTbA8jQtukswdB4dKkGZGPeE0FbSeZPkPkYpPm3ltB8W5GpuLoail8wpLmcT6m
 vkFQbPvewykwX07EOElTLSyXTHsfd9Wep4PkZe4fHTB8K3YG39F5YU67hS7ONFw3qRrb
 1BTYi53gHc1hRYOhy8CL9QtNwabhj8uHTL1m4PvEkSbvF0dYjlK4YIvdaivFmaaptIXY
 SibLCKQQslzpGx+Kj0qrHOSeNNWGh7emi1DhZ9OwnqBQ+/z0XhbNvkOJlsgQcHKZP/MX
 1TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036202; x=1794641002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWhXXg9KugBk6j69su9gcUtst3e5rIB/0t0PjRsXRGc=;
 b=gl3DFMjF9bYmIdKBNwM7b/0KItG9PiEUoyHJdMKUTGONl/su+vpcl5rtaVLy3maDPP
 8OgSrMPWUZIxZmkRQM2s6gjn0jfcnZgD92HcTs0VNQo4QhWyOZsBdieF+Cnklg2ORfpc
 RSHKQnzU/titlddY4d/EhvKOig+BOYVRQJOoTefWcjvB0gksHu6KQK9TgEnAL2vG0ito
 oi2a9CqxopgR5iWDTErbrggfUv3WwE2YLNbi3AQrF8FUGbii24J/vrAa7ZX86JxaKiNE
 GEYOGe0ZwRg5hr0FXJ0/nFbO9HoscKzSTYzVbB7an5NeLv+gJ0C6Urri8ponHmYbV8AF
 2QZg==
X-Gm-Message-State: APuU4Z83Cg1D0K2sDDDTQ7exQ6jbWwVIkPDp56eGF/92BiubC7uV5U1j
 POOU6NtvQVBI5NZ/4z3Qzxrup+ojBFZ3ZDhMEzUXgLfphuMtoanfdjs6slYNYqxdlqtTg3DkzIS
 7QpKL
X-Gm-Gg: AYBFou3COeUPl1jNGIEy1tKYo87he8zwr8WOm4WUk4rFW7tQGgHPLEHEpad1qhpBEhO
 ck5R2OMm1fSOqshNPlrSU2xbQj3qs+Cpa4NvNRZs9+DSFY+43a3sKzb/N4kyGwJQpQsgHvdoWAT
 2sBF6GVEvRIybYXZYjmvjQme41U7X4QNOMKe6FDoyRG/RL8sAKpmbGp4mJElDvXy+z2UqOc58vt
 yooOix7IzO+cqQ49O2wj1ctmKb3BkqxYiM1S5/XlsgAlR5Wr0m3Fge/l1ag5dHoa04mvGRZ7DT4
 0/KA2tP7Za0FAYhQfsgb10k0GLNECnN6EbPPLt8Kioumae/gdfzBRXqWfIIG7RCgYsSqzQLwCWs
 mAuukeRh8zFgrtV/3I0H+GMn7MzP2zn73dVpt3RzOXZC13/bBcH1/IiaxM1yyUOsCGqb713FUt8
 h0Y0xc6eNoDZPA/D2Dc9NGwB/zJxijDA9/fIbxpPT+QSyBy1+BGo+83e3dVMQWRpppNd1Vm7d4l
 dgnBbHeVeOH9ndpbn62Lswhq45aO1qV686SRl+eF+0I8kB4/m7dB8pCR+UZYROGzeVdNVQ5Cnd+
 aDLjXNTLeT1yyymML+hfv9WDJORs7/3pZRvEZPGjQrYUUsbw33RMisQKk4ebbI9XXTzeFi5Kdik
 6oXg2cgatRg==
X-Received: by 2002:a05:6402:a583:10b0:6b5:7f5a:b133 with SMTP id
 4fb4d7f45d1cf-6b5977f584bmr3796936a12.3.1794036202085; 
 Fri, 06 Nov 2026 23:23:22 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe545sm1490649a12.23.2026.11.06.23.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:23:21 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v11 14/30] usb: dwc3: gadget: flush and invalidate cache
 around transfers
Date: Sat,  7 Nov 2026 08:22:08 +0100
Message-ID: <20261107072224.3492260-15-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Same problem as ep0, but for the normal endpoints. In U-Boot the trb
pool and the request buffers are plain cached memory, so the controller
and the CPU do not see the same data. The resync dropped the cache
maintenance U-Boot had here.

Without it the controller reads a stale trb and no data moves. DFU still
works because it goes over ep0, but ums does not. The device enumerates
and usb-storage binds, but no disk shows up and the host gives up after
20 seconds.

Flush the whole trb ring when the endpoint is enabled, since
StartTransfer makes the controller read the first trb right away. Flush
the data buffer and the trb once the trb is set up, and invalidate the
trb before reading it back. dma_unmap_single() already invalidates the
request buffer on completion.

Reported-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8d4b2fc22701..f2a858c3090a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -947,6 +947,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 		trb_link->bph = upper_32_bits(dwc3_trb_dma_offset(dep, trb_st_hw));
 		trb_link->ctrl |= DWC3_TRBCTL_LINK_TRB;
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
+
+		dwc3_flush_cache((uintptr_t)dep->trb_pool,
+				 sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
 	}
 
 	/*
@@ -1385,6 +1388,9 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	wmb();
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_flush_cache((uintptr_t)dma, trb_length);
+	dwc3_flush_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_enq(dep);
 }
 
@@ -3155,6 +3161,8 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 {
 	unsigned int		count;
 
+	dwc3_invalidate_cache((uintptr_t)trb, sizeof(*trb));
+
 	dwc3_ep_inc_deq(dep);
 
 	req->num_trbs--;
-- 
2.53.0

