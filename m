Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E36606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Uqqeg8Mt;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XaUgpUoy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C826811E0;
	Tue,  3 Nov 2026 13:05:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26-sC1biHDVt; Tue,  3 Nov 2026 13:05:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 802D2811AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711140;
	b=UU3jo2MxaUO4m3fobx/fsEc2MWlFqoGxlZPuOCfjwQq3fIiXqn99GEB8FvsDOC5jc8Z6
	 hZwUgnLfsN9EMkdFrLlDdv45Zf21ciPy6kKIzZqhJIhGSZW1g8daHJ4qsRB02ozq+mBF7
	 in6mOMqtoN5cRLPNTsJffnP0r0qxCf1PAgl8T+cBcgDm74mkJCpZpwT56vuSHSosTofJl
	 muiO4rlRkIvIQtDb2+zrwXpyWcApslZAbFeK6IKqr/t/C3hsCXXjblWGgpg+vMBkoDFNN
	 p79MyEOw/gBAx0p35gh82uFG/oDSWhHgHb9fj863dM1R05RlpzFeqoo/V2no9xJHeXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711140;
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
	bh=+pvL2WOY2aiceIH05stAtO2WZHOPo1a5Zmdshdyjazc=;
	b=bsMtjN2V7+sb1zA2sjkPe9BtjRh4pqFDXhxY/7Ksj/9uXWWvIy1tL3uFZ/spAlnkKQi5
	 k+P4WSQK42ip1/tMKkLxChHiYovU+2ilGzQATd00U4utzfVWuwklHQ3mO2rQ5oWEF8iEg
	 Ujs/Otjxj6WcAgYWMAOJlBHytTwPnkYKGttRPUssBinta2hEJfoQkMunSXjxt/xayY4CW
	 8GCIQDsKHUFC72/EcJhukHbzYzAagRhFv4WQK8c2mCBuVzeVOatMzhkATqY9/Z7T7LYpg
	 W30i8CRRv6gIJz/7q+BWl8XnQBvKTIDBDTnz0ial5EJGcJvhI4jt8Qn9c9lwpuCYExg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XaUgpUoy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711140;
	bh=+pvL2WOY2aiceIH05stAtO2WZHOPo1a5Zmdshdyjazc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uqqeg8MtEU5QSGocx4CvHBUN5Rm+xXHc4QSEYP+nJW+7losdRrRDnaC5cJlfHvbkf
	 Pj4a2b3ZD9s2VSS3a/I5S1aZof1SYmC+oPZBLl2xLltjo5k7hb3oNzP+Ux9dppKrIm
	 sOPXM06WHyiZjIMsl4MQ7qvahw+sZuziTohjAxlqcI+Pe+mF6bxlQEoDPK5WrRvke0
	 iAdn2ltQc9Kdq0gU/fZ1Awdxaea7vVMXNHJB5s3/VnFFE0sDGGscsxVGYeVuQnKame
	 p3bgXZ2dA4uCE+CNJsSXvkEkghwtS2dpmQIu+0zdrcdWu6jrYob1OOVqc/iHhyNI7A
	 rop5u18JURMTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 802D2811AD;
	Tue,  3 Nov 2026 13:05:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 36F3E435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3418780C74
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWUvs-jIj2lZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:59:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5EA7480DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699947;
 b=C85rxJsC1gswEI2TitgO4rPOIDoAKkoObQDWivCmHphN/J8r0UfdAVrNLoxffExGOxAn
 bnrqpjEtiJt2uxSRAZxNACf6mXhsTA8/+GWi8vPz/eMAhhcxGr9gT1cmdKNQ9StFd7VLS
 GYHXBF1GsySrYfDXZkRkpdCF5vLCbuDlpSHgjcA7VJM7EXzs7Y7SkwkV37nI3fxTvvj6h
 L35WfJ4LRREr+7GRx9LemRputqjZVKjud9MiRkIYMVVZ4sXA9gKARro58hsoyBm6pKa4x
 95awfR+mAIx7yiVY9SQTb/SL9omZOEpe9WVndygya2FwEX+taa/cC/yeHI5m1sj2vzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699947;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=+pvL2WOY2aiceIH05stAtO2WZHOPo1a5Zmdshdyjazc=;
 b=cgRD8m74/CYzcC2QuKpCqjL6patYU8L+9h3nEd73YW8T1HN+vAixklUj/QcoC1J2jbao
 lD4BcKou8b+UOV6poQhiFK+hHAcxH58NQKCun7yufJ3SJZUXUK4wHp2OR6BZL1c3OTpA+
 mUyUd5m0nYYkqbaNu9/wGCKFVjMVJ628X5Yq1CV2FY93JJ7p0t9A6gzPqXZHQnUtoqCQA
 2lgvMj9Vu5ARYyWzwLSwC1Eouly4evU5tWjqxFeCC5ZzVVm7spXYeHp+AC18w2O4xpPT/
 GTuZQAkXpOYLn8mn/GYp/TTlyg8LK0SjjMbbFSaddaG4OswwV+9MTGSJb7+VUKRF6Ag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XaUgpUoy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XaUgpUoy
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EA7480DC2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:59:06 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so33452145e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699945; x=1794304745;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pvL2WOY2aiceIH05stAtO2WZHOPo1a5Zmdshdyjazc=;
 b=XaUgpUoyKGuRwaXfQ1wkLKWvc87MotWjGaGjASNaAlrEugAme5N8YjiVnlwPFHNFUu
 R00txAnIYZAE/lqYZpnLBNKsMq/8I0yC7+/j1RQYJQmEJwHdKSgSKKj89cfULmtw35AS
 sDKWeQiUMpyBDvFCYagmuZQzAx2clHjs5VP4MpdEEGjtHPqhv7cJNYe9L82CFhsK4J3s
 O6QsoTdq6pWKWaXxCjImNk0l9+CSEgB0owqYuM1iwtnG7TIkrC501FxD9zDbbGZGeYv0
 PFTTtw1ywLy3019Qs+Lm8BIM7IOM63QX+tZyp3yHJ+BaKfdbcFdcvBlkQ7ZAwTE1ibWl
 1dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699945; x=1794304745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+pvL2WOY2aiceIH05stAtO2WZHOPo1a5Zmdshdyjazc=;
 b=ZZE6Q0NyPtfj6z/AWCE72YmnBCUeHFW3j2I4lNHHcMFagIrhY3sunzT+qNEM/Czprr
 qR73fq9FJYQYR6ujW/r6KusZ9BYmtB9cteUobRN03G+otcJomBAswlo1apd8YdSbfPaJ
 8yxSyvW7chBwyr1Ny/TyOSLjESuCiZV72ikoDeuYu0NusAJ7Bur2U5UPWYgCwuMmx10m
 VPuYH74KptBDCRjswelAUbgrP+PCm1pryk0x3lDAUyay4SLyUt/dqmsjTX+ifQSFXr45
 1BrjMkb3IWh0qI/8GAZXP4twKY/J/DtUQCe7S6X+93hqdABHxyzhcD3a+gB9JxI6fcdF
 Cxag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM47B+aejLmNFP2vzBE9JkXpKF6IgSOiqHCY4TiIp5iaWeUXwiKMx9U7CwJTGrq8u+XJvW9n0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z98rUcXKBo+UNeNEsgz0gUUB8skffjF5b52c2qTDBfD/4qX6x+e
 EL1ya5dV/MNJw7cJJmkp0biEDD500u/cnSx6BeyirClLB1xgt9y4dOFWREwSEzb2f6k=
X-Gm-Gg: AYBFou0jvnC1TR0Eji7GOa96UnG2wQMMkfdWcnnGRGlKC8i00Pog473iAzm5NcdKPzY
 qCAb+Br0YpvO2RGGIvvyGYKnBGq3u8zl5masIfO1WSeqRZ8oONt2IjuV3vh165HTdBwfmJOfLpR
 5EmNjSR+ta/mAjLlsaICd2oQGg9bXZZj2724YOCVO9rgzBqhkkn86WjY2nDJ7aahULs5xI1qKcY
 lsu25ZhDnNt8nOfD2TNMUpEKcVMnks95wMkK19+I0i5JY/Gb8blLcwMPfYZD4iXfZFgId8JjYon
 842NYkRIov3LdEp5wrxyaVS0bHqYM+Rhotpl9cQbR6UmNbQWCIWUPHXpKlcqN3KC6nXZnmdJ6IF
 1rXkfFz4zQCIPeoOtPkGMmLYSi0l8wjipnJsGiI7wauZY1kJIqJrSoyVlqL3hI60+Tfa0+wbpkD
 iK1qsJMCaM2Zjj0cPI7uWLzUS4qlobsd6R58du4e1fNjKl/HRDb8M6Z25+PZbieiKZthz8RbwAI
 aGZriFiSAIOaa8rTwwBJbHMYmPwfBatP8lnmsJNUHq5XXEo2K9/ZcHBeUNfFZF/LWd/9XB9c+RA
 iTADMwZFKS4eUbbbHZJEyr7F3S84HSn2MwVyzbbA101RISo=
X-Received: by 2002:a05:600c:a00a:b0:4a2:190f:cf6a with SMTP id
 5b1f17b1804b1-4ac19802310mr286850675e9.35.1793699944828; 
 Tue, 03 Nov 2026 01:59:04 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm24761235f8f.35.2026.11.03.01.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:59:03 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:56:09 +0100
Subject: [PATCH v10 23/24] configs: am62ax_evm_r5: Enable IODDR resume support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-23-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=msp@baylibre.com;
 h=from:subject:message-id; bh=IjiOGSThj7hr+gzCXjXsUdhi7sp7lsoQeGZDG43lHXg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyXG8w4Nj588UViUdWvuCjeVXM9Jix8ekFjZmeYXvlK3
 RWL3+TN6ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJtCcw/A+991rM8aV/v/Lu
 VK2nZUc1Ixo64ncJvBBfUL7s7tqY/EMM/9S+P5zwy+bYQtvvs/fvS+pUc9Ra/1Xj5Wvb2xfXbeO
 pW8MLAA==
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

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 37c034890cc8..57b352397229 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -102,3 +102,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.55.0

