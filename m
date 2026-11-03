Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94E606A33E
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lH0GMdP+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VXLi0Bwh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC8F04082D;
	Tue,  3 Nov 2026 13:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnM7FcsxmHhk; Tue,  3 Nov 2026 13:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C8E4407F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711133;
	b=aE28GfplscYVkhgL05YC7JgEuZreBHbiZh75DbhgJywTf59nw+kiIyesbulylGw1tWeS
	 cx7q3z2o5fHhvZYCQaaKLPEPxluqc90h8sGdLgAs1l4eqcyCX03yAOzOGJysXLyOuNoSl
	 d0f4wVN8tdRsUVB3+Ni1Rj4iMLezQ+U7pgQU+Gftw/GAyhCddWootr4b48ONrPicmUChE
	 mND61o831y8D0rs9sO3zX/liCvGlw5TwgRGziuzkGJnArnrU0Q0T9K5OnQT/O3acv5qWl
	 qcJuwQwoH4Fo7r7WIRU+xyFo+zUUK+AUnWqw94L97T6oBihXltRrnQQ+obvtkc12ETQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JVbS36PGPOWk+0c1zDQJeZQtZlursvuOY4VMREy8ra8=;
	b=SPzGUhph06VToCxUtrNFqa9LtoxJBMAHjod200hhb2Qc/uUwL0PBewwIRNr8Qv/EAvML
	 ksv4xUuz3tdlG9g1LvpgjV6evRyWo0XXaeYrEao87KSo+l8pMvu83/VtJqGfUWBmlHYuv
	 vBWnDZzy6nc+hzKOw/MaDDUqrrr4zwjrrboJMdBwXffoGmzTX6tazskruUExgE8XdCS3M
	 tZv7QdquMXaJRWU+/W9L6palmJ2A92GMKvl7CqykfsJoVnJgzZOTfocE6+UFWd3gBwf7P
	 P7HxaTZKrZtgykk4WMj6usq15kMHmhc/go2zf69AnJY2Ftxa+UE50scSCLdfj0Az/CQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VXLi0Bwh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711133;
	bh=JVbS36PGPOWk+0c1zDQJeZQtZlursvuOY4VMREy8ra8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lH0GMdP+cN4Qk6nwLBUEa+rHWK19JfqmD9sDxg5bVKVCBXGfd5MmvHR2N/z7iaJF0
	 FnHmk4zzF6ASYWxzLobdzO+2rGvbHoUOxVGVztQzXQamlOydNxiPQsjoDkXYAVlOYb
	 VOJSMKBLRDfzhSQJRQFI2w1tLHDEnuFp2lCUEC49KzvjoYGT7O+i7ujtSa6j/XTrbP
	 scEDJ4WjeQnDEppX0eWRYEOT2E9OTZu3NbEFZ4GdllNKTn7pGfgMBX5n855qvOeKl5
	 TO6XVfnd4amC/NCybUb5IJ4mCWDGVLFblAIlvtRbLDrLjVh/m7DWf2w0k0XVt2iZ22
	 2wj09qE36ajsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C8E4407F8;
	Tue,  3 Nov 2026 13:05:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E19FA435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2F0C4047C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tdw67sa9YirA for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AD674043A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699940;
 b=qWIpW+fqQMkt8QrjiDrkp+jkIHFsIU4dvFAdmaOyWJdvKxrkYHjbPYiBIFuWqleI65jA
 QaFR6Az+bOPaMScsDAUvhZgXQRYoHyq5B+11gGU727bLFVzwoNg3KKrD5vhZprMeXAjPU
 JUM+plFZP0K0fHO7qwf3BwBawv/9QzMmtZCx50pf8L3tFT2Z2fyv0SN4UAzUOHpAvPlEu
 M4oWqLYOlRiJ/uO9itejnB0sFOvD1t1yznt2k4966A80jDu86MZKR8n+AHhuJ8PoHQ24k
 kjpNzPdxzC+TioH2HFIX+Rart88hHBJuVT4GoyV4mLvNudBSTSaDX2+M15j1pTYVT8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699940;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=JVbS36PGPOWk+0c1zDQJeZQtZlursvuOY4VMREy8ra8=;
 b=Te93gn7xP4ORFD4Kz0gjP/5g+A8wUETUdQ6eBxgvJZlyQYknmabU5Oy4x35iU0vZK9bK
 GC0C1g21r7Ge85qi4fWg7lSWokkSH5KSrRwUmBmVm4tHLUcX5UChNiU96CIZY7dJECAog
 333bjz0qqDuB3y7BASpvje8hjPyNVxCtxUo7XnbnI0smO2G8TlrdB7Z3shmuHMWaaq70S
 fLc4O9LooGmbRrHjBrbhtqMHY1VEz9QYCSVdEirbhehWAroTAR0BnTiNRaU2nQdh1vnj9
 OXDERSoN6oyslBNYRlE6OGgqPw22UkZlX8SrATfrTUuia8gWgxV3vwnabYuc/ZHCYUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VXLi0Bwh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VXLi0Bwh
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AD674043A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:59 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2362569f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699937; x=1794304737;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVbS36PGPOWk+0c1zDQJeZQtZlursvuOY4VMREy8ra8=;
 b=VXLi0BwhjGvAeUibSR1NcwSQM5ZN4vmLllrqohApXcOWIQENgKSfecO4smz0YqA/Vc
 8VhVV2lPZ46u8itqEixypn4y83dDYygnLKcpDzIoQSOjHQLVPzVZPk9C0Rvt6Gk8uRLe
 JiG176J6hYis8EpMvDbleH2BmrbdlXj7SSBStKvjO2lCuDrr+QqOrkcnMHblLCZle4bA
 Q/dWu70vFafaOPEFjoRoDQTaSy5gNdsqsV+ze4le4nYnhPJcAnaVipZldB5rEN5nbya7
 2mpflBQ1t+VxsKzYhXir/SDOdNEtbCXXuMQMTrgPGcXNMZMR55xWWR3TrdMjA9Ad+ma+
 SSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699937; x=1794304737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JVbS36PGPOWk+0c1zDQJeZQtZlursvuOY4VMREy8ra8=;
 b=sYblUeKoJWE3z5eXeA4eaxkTGYHQ2W/lQ8k8cRWqjBLkzJmP/assO/4+iHu2BkXsIo
 UaI1G5fnMkIE3z6KIvqP/FGAaT6eI9QXCTChn1UECM6u/iVd6JzS7kjSznicKbr1+9Cj
 HPIp+3z2zew3eDNGlfG+SVKk/xtt8rg7zzBte8E3fAgFcGGQ4MbOcobJE/s5UjjPSBlv
 yYI2j2LDpkrwiaCme0yCUJNMPh110CE8lfP4XvwdSD1Wk1Vvu0sfBauku6I1yIibsb5v
 OsUfoEMSNCFlhDvXwbGzpf0cDAqNKXbPZNgK1AZlJlP6BMZs5muTQTLPhkMxWzG9Fn+h
 wJVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq+O5TAdrUkNkjPHkpV+gquw3uOgz/8duW3gbSPzSHhfMe+q8mJ0ssznJDxw3G5vtL4gzebPo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z964L6cWy/IMzv/k3hea+4ssEbeVBD4IF0g377V/azAo/j1uNWX
 yI9a0hx89/nWRLMRGu5Im3mTtcr4yPD4IPOatbYkp5EmAm6eH4jP9V+Pi2Z5+aqRoYc=
X-Gm-Gg: AYBFou3VhBy3bG33MhgL9CQsEfCCS67/1j6Gv/19Lb0BiG7keOnNrC4zluLMNdXCRBz
 AvA6I4otAu7oF/03fuAnzH0kHy097gzq5HufSvZm6FFUDuYRpaA/6vKP+SWZc4g/D5vwgXRydaH
 hTDCasrq9IvGGD/wdDOzpCb2yfBHXAawDJp42GetN7bjeYUwWedQx0THwaLYgR01vvMjA+Q2vhR
 0OlzAojdQAkrNMWs5VGRG7UYUmG0nmdo4AIuhO2J6W5iE28BscLiJIQ7+OwJbDFXZYoRPOOy48V
 Nj6rCPAML0d+AxtYizDMYHMRL12ZdMrhzt7ud5YOH1Ep+DOJpui6SSPSCGC6/SgAT2mFFsH6SWa
 cg2adSVAJoY1/IY0nazCpoO91JTKj+Em0Jo35BElrkAowwROexKRbOMTCDtxZCzVwml4BZr+ase
 ykrESnLsVGn1F5GgLruaxYBhFqxHVtxPLDxscuX6katOOrUJdw3665cQqwtjxjRMXkeJ+bG2pO8
 0tapH4iFOLO71GqvfyFLLTK4zLInI/sy19BGE3OTKKGH9jUThP2HwES85e5pNKm88Jeuz37Jn1x
 BcAeZDsWARMqo2jbpyYV9DuRgA==
X-Received: by 2002:a05:6000:98d:b0:48b:e50:7159 with SMTP id
 ffacd0b85a97d-48e6e2f6818mr28216106f8f.30.1793699937155; 
 Tue, 03 Nov 2026 01:58:57 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm24115644f8f.10.2026.11.03.01.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:56 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:05 +0100
Subject: [PATCH v10 19/24] ram: k3-ddrss: Add workaround sequence for
 errata i2487
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-19-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7002; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kHJNp6xAP3JBao3zTx5XhgXnt1jq1ikHhc7MBWCN1No=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG5QzvwQu55v4esO8uOvT8zPMb/x98Gr9vNaPjUe/z
 pRu+6b5rKOUhUGMi0FWTJGlMzE07b/8zmPJi5ZthpnDygQyhIGLUwAmksfDyDC//ADzHpk1n/99
 LvRqWf/rx8MtKnfPHwmoi4msnWi04KwZI8OG09/yHCcmeOx/Y7VuxWSB4Kw3X4tbz++/Vbd8i0/
 k+Y0MAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
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

From: Akashdeep Kaur <a-kaur@ti.com>

As per errata i2487: "the low power modes may inadvertently corrupt
DDR contents" for AM62AX[0] and AM62PX[1].

Based on the recommendation, add SW workaround sequence to
clear data retention latch on every boot and/or abort scenarios to
make sure that latch is initialized to zero rather than unknown value.

Executing this sequence during boot helps to successfully resume the SoCs
from IO+DDR low power mode.
This sequence is executed in partial I/O resume as well as all the
other conditions when reset is issued during low power mode entry/exit
or when the SoC is in idle mode.

The sequence should be executed for SoCs that support IO+DDR mode, that
is AM62AX and AM62PX.

[0]: https://www.ti.com/lit/er/sprz544c/sprz544c.pdf
[1]: https://www.ti.com/lit/er/sprz574b/sprz574b.pdf

Tested-by Sebin Francis <sebin.francis@ti.com>

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 80 +++++++++++++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h |  1 +
 drivers/ram/k3-ddrss/k3-ddrss.c     |  5 +++
 3 files changed, 86 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
index 20181d0a876d..85fceb080d2d 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -25,6 +25,15 @@
 #define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT			0x43018318
 #define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL				0x43018300
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD			BIT(0)
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW			0x55555554
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK			GENMASK(31, 1)
+
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE			0x43018310
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW			0xDD555555
+#define AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK		GENMASK(31, 0)
+
 #define K3_DDRSS_CFG_DENALI_CTL_20				0x0050
 #define K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE		BIT(24)
 #define K3_DDRSS_CFG_DENALI_CTL_21				0x0054
@@ -51,6 +60,7 @@
 #define K3_DDRSS_CFG_DENALI_PHY_1820				0x5C70
 #define K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT	16
 
+#define AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS	500
 #define AM62XX_WKUP_CTRL_DDRSS_RETENTION_TIMEOUT_MS	5000
 #define K3_DDRSS_LPM_TIMEOUT_MS				5000
 
@@ -179,3 +189,73 @@ bool am62xx_wkup_conf_boot_is_resume(void)
 		am62xx_wkup_conf_canuart_wakeup_active() &&
 		am62xx_wkup_conf_canuart_magic_word_set();
 }
+
+static void am62xx_ddrss_clear_retention_latch_and_magic_words(void)
+{
+	int ret;
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK |
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW |
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      true, AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS,
+			      false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
+				 0);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_LD,
+				 0);
+
+	ret = wait_for_bit_32((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1,
+			      AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_STAT1_CANUART_IO_MODE,
+			      false, AM62XX_WKUP_CTRL_DDRSS_RETENTION_LATCH_CLR_TIMEOUT_MS,
+			      false);
+	if (ret)
+		panic("Timeout during latch clearing sequence %d\n", ret);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_MW_MASK,
+				 0);
+
+	k3_ddrss_reg_update_bits((void *)AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL,
+				 0,
+				 AM62XX_WKUP_CTRL_MMR_CANUART_WAKE_CTRL_MW_MASK,
+				 0);
+}
+
+void am62xx_ddrss_run_retention_latch_clear_sequence(void)
+{
+	/*
+	 * Workaround of errata i12487
+	 * Errata states that During entry to the Deep Sleep or RTC+IO+DDR
+	 * low-power modes, SoC may not properly transition the attached
+	 * DDR into retention mode, which will lead to corruption of the DDR
+	 * data.
+	 */
+	if (IS_ENABLED(CONFIG_K3_IODDR))
+		am62xx_ddrss_clear_retention_latch_and_magic_words();
+}
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
index 742d224327e4..0b292d06138b 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.h
@@ -16,5 +16,6 @@ void k3_ddrss_self_refresh_exit(void __iomem *ddrss_ctl_cfg);
 void k3_ddrss_lpm_resume(void __iomem *ddrss_ctl_cfg);
 void am62xx_ddrss_deassert_retention(void);
 bool am62xx_wkup_conf_boot_is_resume(void);
+void am62xx_ddrss_run_retention_latch_clear_sequence(void);
 
 #endif  /* _K3_DDRSS_LPM_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 54e191df8de9..9a239e93c123 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -122,6 +122,7 @@ struct k3_ddrss_data {
 	u32 flags;
 	bool (*is_lpm_resume)(void);
 	void (*ddrss_deassert_retention)(void);
+	void (*ddrss_clear_retention_latch)(void);
 };
 
 enum ecc_enable {
@@ -888,6 +889,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	is_lpm_resume = ddrss_data->is_lpm_resume && ddrss_data->is_lpm_resume();
 	if (is_lpm_resume)
 		dev_info(dev, "Detected IO+DDR resume\n");
+	else if (ddrss_data->ddrss_clear_retention_latch)
+		/* Clear the latch after any reset or partial I/O exit */
+		ddrss_data->ddrss_clear_retention_latch();
 
 	ddrss->dev = dev;
 	ret = k3_ddrss_power_on(ddrss);
@@ -1041,6 +1045,7 @@ static const struct k3_ddrss_data am62xx_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
 	.is_lpm_resume = am62xx_wkup_conf_boot_is_resume,
 	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+	.ddrss_clear_retention_latch = am62xx_ddrss_run_retention_latch_clear_sequence,
 };
 
 static const struct k3_ddrss_data j721s2_data = {

-- 
2.55.0

