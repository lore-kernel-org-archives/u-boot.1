Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FC606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V/2lyUIU;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=d+jx+NIi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F8DB407C0;
	Tue,  3 Nov 2026 13:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXplEmN0G-fj; Tue,  3 Nov 2026 13:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF662407E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711112;
	b=kmdYgtH777lxoOhZDzTXrtjAUeDC/ecC4dsBgVqyWwn5cf50aTzZPg9Yl6F2L+fqF+AF
	 rd1zLJF4jPztMQZC1eYQP5bbgrIvEn19rZWwJntfUHmubdaa5sInrpCXN8hUR+wcnOTxe
	 /m+navn39BxMiWlj00YS4kwBljFaRSFj8bZY3Tgxu1TWnB7VConV54wMJPhZVLbobTDk9
	 bE6lU7rUMCs4jXU13t3RjBPhaZgxxgJp77YLmU4Q9kvlgYH/g+R1qBj9GP6OEdM/t/Vbf
	 rwDZxjWr4gLINLGXKsJsCx0VhdZUP4XEjkPvLO9r44Y4bIcukttQvABNdkxhzO6bIuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711112;
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
	bh=GSxjhTeyFvbo6Bt80Guw1EGRFScSeVYKeee1HdBt1Gc=;
	b=n59e0tMKabA/vBYRNeFxO68VmcoVe1ptCFSGmBbh09gL0KGHJFDBZ9JIpkAi1jjr0BnO
	 wyTG2BkvMElI9iFwe5rz94ZEJXGz8hDSzckQIAHlP7zdmdm3E3xPbGQ3tZcuvozAkiIyU
	 pcXI0HPj++7ZSNJN1TxhGxzvXKndIRbzwrBfPFSr6BF+DK2fPnn1fKaFQhssXALI/dW+Q
	 xs4791go+pzWSdpJTf+Tw8yCVBs6l+8JISz+TERB7YAwOxIOipigwIf7f50aMB7Nz23pm
	 oG+Dpob1DJj/ma4XvKAgy36TkfkPfdUJgp46aVRkcMNZAcRGgFIIhJh85am2YvSCAEg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711112;
	bh=GSxjhTeyFvbo6Bt80Guw1EGRFScSeVYKeee1HdBt1Gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/2lyUIUDLtwMJM7FYqXofn5N3m+M3EAnv6H4o4KqppFp4P26FIB9+PUby0LOPhoI
	 Oft5Tm/Ci3EP/0aPLypu9FvLhrH1vmGmV2daJ+xMrPbrmE7i/KaAZUe9T5BrL+dn3O
	 TTHfDRq9hYgaBoxBpff1I4A0esQEbKgaw60A6ZgbmpFTSRZISHHDlpxewnIMedNurs
	 waiTnBVp27S/6QHDj7OAOB1lvJ3QpLpN1kZuADWedvAyAE9DO61NVd8sX23DF8JOTA
	 LpqAH2nRC4JNbVX2E/d1QBKssGTOUpwpTISZEQckwaiO4ZDwQf9vxERLuCkgVWf893
	 R3SG6lZIreKGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF662407E6;
	Tue,  3 Nov 2026 13:05:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D5B42356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC5A640080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QwQGBySeP3Ms for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 79A8E4005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699920;
 b=UlRDnIxMoj2AxdTn3op270z/cAtW0i6WvHhrowuiQ9p2UHuq1DEHDoF9Vq0F1z1+wfsh
 GG/2Jbk2PCsdu3skZz57AAZp0T7EkW6OxHPJLKvzhjCRcLwrNC/gVB/f9xwvKipwdavmJ
 pTW/gUbtyItkcZz3MTrA43xBbsdDvRlu7c1fbdZ7YKNIRFW3eROzrsm7RmncodzY2q2BU
 dYbZw9Irf3h3qRvQBKkRIbxRgNmecjh41H7wD2oYfC9U+C8KcL3Ybq6sqZNDCD+l+NLf1
 DMaIpcMNqFKttitF9MURgashWUaw9c783+RDekIWzvn6eHqSP0fW2tS5UV62stw60iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699920;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=GSxjhTeyFvbo6Bt80Guw1EGRFScSeVYKeee1HdBt1Gc=;
 b=sfHekaeHB8TqEwsbI1F7Ei6VGTeOLx56Yj3J5ATZZM6fFdG9TYl8MScS29ocbr/vteyd
 vPq4O9aKFHr5+Pxz1MqLnqvv3fp05euvahINqzKrAYX2yCZb2qqxu+AFHJKgZO2k+2cr7
 VpN7XSmraSLc01qIrJmvnLaPkDlS19fHqYcaPr+THwr3QbNk5Z6k01yJIff+4MKYuBy45
 c7q4cFrZk+6a45v6TahgKPktMuJj33T2kbBeFJaatCAzyN3s8Sq4Dy1DVMlId71ILEsL5
 Nq3bsfHKQlmK1PeIW1fOlPB1yLPHgifPE0IGoArngUYb2FDEmwIDxMkUYrZ9fKhrUcg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=d+jx+NIi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=d+jx+NIi
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 79A8E4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:39 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso3481558f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699918; x=1794304718;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GSxjhTeyFvbo6Bt80Guw1EGRFScSeVYKeee1HdBt1Gc=;
 b=d+jx+NIikS1q5LY4YFuApwPcCVm/phcz6ahHdRdRmbPw/BUEZNHDTi79t+4xlKkrFL
 xyctUvuRDDw6uJc6BIPofYB8zrHlmBLVNLJxY3KpxdsezUKCdUjn0bvUDqqdVTBgqTNy
 Igz86m+VFiCu2j9yaPgqjJMtJ9qdqY8KiPPIND/DWVIR9bzdgKYvfmadnxlfLIPZUs31
 jvFRy3qQLZ1M9qJjBi03Rfkw6fA9ROfL6JECPlpibuzRZ/IUfsbykwKFP6SI8cDAaaX/
 Pnv98tKZ/8VHmTUDzqO69l7Sog4++Gzhv3MTb00wbtBb8VfkuVzpC/NosKTDjWpaip2H
 HcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699918; x=1794304718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GSxjhTeyFvbo6Bt80Guw1EGRFScSeVYKeee1HdBt1Gc=;
 b=fuHs3qDs4q8p1gqWVn28qpiBwxwmonvpVSIUivS0yb3dZG/KRGYZs8GqVtrpUsh0Lj
 CTRJMBTecDNyI7zSfltt7sNYtH+hhsN8Nsw+1wmVBcputR4Hu+7Inls7XwtkQFATuiLQ
 fUi1BSSqhI6sJAfPfPcarNUZtKh16dZzYY8rNX5PonVqpmnnTw3G4UEw0Lf1OhP2xAgP
 G7r4ghHwP8erRA2AklIbNanCxefwsytYr12xz8h+j/YgqT56QWWKifAiNTVcM9DajlVt
 Woz8O5gFxvTqYVuOPsg9teAv1e2GkZ588qWbLRPFihHmEG6H0PR65kYjvXf6OMM7nMeR
 eS1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiqFY+Ju5lqVlaV6ge/HdPtVOmtcF1Wx/wHmMFKZhJiILqbzJzVcxybN2jMG4KMJr5drknqvg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+JkMJBr1JriHnxOf0ZN+Vy0VEDXeEkh6/S9HhVeqW+l5MCJxDJ
 gMIcmxT956u+o+RBOWmL4KX+e+072JUrQLSjngWsxZnL6GDe0bmLBZx1Sx4OySgAr4U=
X-Gm-Gg: AYBFou18WISQSmddI4PFs1KMJtOUDB0xY4/qUWm1r2bix58FgDDN89XoXd79DeZL83a
 UK3DGbiCczjV+/ncc8Wt6oqFRw2WcHVuMUbl23TOr9BvBF8Jbp7+CBm0341S0iAtTVjRzy+1dSN
 hx7DNvTFqnL7BDCMteVcCxH0R7weesu9R2fZAgKevMRNycv6i0XByXWMTyynnLG7kVeP4XCGykA
 ZHzOL3xuram50k6A+HEs0T5W6NhT4qIRd4qtozLpcxEL/RFAuz3idmkFS7cVQ2Ayz0m/aD7NxBC
 gq9IvCOwzacJMulr8RKaj6HwqLvDlGGa8beV6bLdR8ep63TUWMZ03SkVHkTn2JoCWbcBzP55FZZ
 IuS+DLFHjdJhDEcyhLltLYFfldCkXZk/GVbgdJYuWi42sz1uyKMgYbNhA8Hj1pNbdv4jpKRS6AQ
 057/NxT8LbrIFOm3iOBFxZk+T80eUs57zd/UtkJNiwqpd8fR+/WsujWiztF9zoGLT531Y2oXDGS
 JFDJaR9/rj3IXqzh7Hs/fhEwafI1rdsm3PPXDJxjsUfLjq34X32778n1dcuTtRCn6DxYAcO0+w5
 39lpnNTjsLB5VzGUkoxzDFSa3A==
X-Received: by 2002:a05:6000:400a:b0:48e:4115:f3e8 with SMTP id
 ffacd0b85a97d-48e6e50096emr29729954f8f.27.1793699917819; 
 Tue, 03 Nov 2026 01:58:37 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b959c1sm23698534f8f.45.2026.11.03.01.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:37 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:53 +0100
Subject: [PATCH v10 07/24] arm64: dts: ti: k3-am62a: Split r5f memory
 region
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-7-0b24ff0a4d6e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5758; i=msp@baylibre.com;
 h=from:subject:message-id; bh=K08aB1lXEoi9fXBBma4JASOyvbglYie+tN+EMDQUQfA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX6x+k5s6vK2Mz9bJ1LustMdju21/0fKJwhMXseS+/Z
 Ty/0/Kto5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZyKYjhrxjLY04HPvnnCrGL
 y9OkY+bF5N6Lrdg39d3kG4t78nhSfRkZfvC1N0075KD3NsZn8m0vQ4kTEbtf8WazNl1YcO/ys53
 7+AE=
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

Split the firmware memory region in more specific parts so it is better
described where to find which information. Specifically the LPM metadata
region is important as bootloader software like U-Boot has to know where
that data is to be able to read that data.

Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-7-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 13aea49af974352c2a6a96608bbaa3ed3030706c ]

(cherry picked from commit 58c41f0943b030e47e3505e510eb45dd52e6667a)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 .../src/arm64/ti/k3-am62a-phycore-som.dtsi         | 28 ++++++++++++++++++++--
 .../src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi     | 10 ++++++--
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts         | 28 ++++++++++++++++++++--
 dts/upstream/src/arm64/ti/k3-am62d2-evm.dts        | 28 ++++++++++++++++++++--
 4 files changed, 86 insertions(+), 8 deletions(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
index 53c096da68b5..7fa19ced1a23 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-phycore-som.dtsi
@@ -65,9 +65,33 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x1e00000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_rest_region: memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1c60000>;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
index 06d4e815b167..94c1d60d8d7a 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-ti-ipc-firmware.dtsi
@@ -65,8 +65,14 @@
 &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0>, <&mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
-			<&wkup_r5fss0_core0_memory_region>;
-	memory-region-names = "dma", "firmware";
+			<&wkup_r5fss0_core0_ipc_region>,
+			<&wkup_r5fss0_core0_lpm_fs_stub_region>,
+			<&wkup_r5fss0_core0_lpm_metadata_region>,
+			<&wkup_r5fss0_core0_lpm_rest_region>,
+			<&wkup_r5fss0_core0_dm_region>;
+	memory-region-names = "dma", "ipc", "lpm-stub",
+			      "lpm-metadata", "lpm-context",
+			      "dm-firmware";
 	status = "okay";
 };
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index 6e5419de8e35..871ec227def9 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -59,9 +59,33 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x1e00000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_rest_region: memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1c60000>;
 			no-map;
 		};
 
diff --git a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
index a8c794d07343..7cba3ff99e6a 100644
--- a/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62d2-evm.dts
@@ -65,13 +65,37 @@
 			no-map;
 		};
 
-		wkup_r5fss0_core0_memory_region: memory@9c900000 {
+		wkup_r5fss0_core0_ipc_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0x1e00000>;
+			reg = <0x00 0x9c900000 0x00 0x100000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_fs_stub_region: memory@9ca00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca00000 0x00 0x8000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_lpm_metadata_region: memory@9ca08000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca08000 0x00 0x1000>;
 			no-map;
 			bootph-pre-ram;
 		};
 
+		wkup_r5fss0_core0_lpm_rest_region: memory@9ca09000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9ca09000 0x00 0x97000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_dm_region: memory@9caa0000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9caa0000 0x00 0x1c60000>;
+			no-map;
+		};
+
 		secure_ddr: optee@9e800000 {
 			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
 			no-map;

-- 
2.55.0

