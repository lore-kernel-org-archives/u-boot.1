Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E7606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=S+uM0Bsn;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hV6kPQwJ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DF6660DA3;
	Wed, 11 Nov 2026 21:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1EMjxtaFGHdZ; Wed, 11 Nov 2026 21:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7120660DE5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432383;
	b=fs39tnQ85gBYtLSG9dVP0HS/MiGzynqyp5+oHg0ZFU84IQaJgFiDuh5ixzcsjsSe++XY
	 YuUSY0+8qLQNI4OUcaPstw6iD+B5BTWsEigP/DdY5jH8qMwrP0c+r2C5CPvBOrzquQ8s4
	 77orN8jFBkezfbafNs3NJ1D9JPB3aUUi6Hfi9B+RRJsSyTN7e2lV+GzUz38Imv4i6Ehyk
	 YctvjYsbd9xhvEORR0FOR71mrYkyQ5E2ycckqL6Oowpd2n8/5DjZ6m1J5ZpUfba/bHCHB
	 Y8J6XXR5WhZJGTjNAE6n0wOJse/n0IuktAlZx4DFCGxknXVzew8aia1c3rIMXNqm9YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432383;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bndDc3iegxWT8LdDN5XEULIE8/nRzjStPc3HeaLYAp0=;
	b=dSWj34F9ydj2mL01c+7GlY2J32aGizWyC8NldZWKji2W2+/DAwo+UMaxI+i47849S9fV
	 YVBJwXqaE1KunZmykdo9UXC2aIjIwkzg6gvapqeqgo6/kcKYbSEhVVJFFuKh8L4GTrDPR
	 rwrayrioCDOMEH6gp8tIqmoK8PeKdTMV1O5G1dx8yNZ8JJgyTz7czFKcNx3FkYTSFvtDC
	 ghWp6k3UVhCb3BhysC0oeynrFj65PgdpNdM9uGsbPejgDLOVJblBH8ssjIAETPHfY8UdD
	 Qd0y08+so4/ZQdqrkryHXrjY5jDxKgKHV896cbfTGY0tvcoZ60gQ/4puWYxEreGNsOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432383;
	bh=bndDc3iegxWT8LdDN5XEULIE8/nRzjStPc3HeaLYAp0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S+uM0BsnkncY4RBqTuJHV9Km80nfeEb39CMGsXvttggeCCxKTMOgwHrc1L5wAD1O9
	 dfScrJDSPyN7dUmMkpIOl1OYGpwSiucOpqtc/2mXvbZKymxvSj1ZAN/k60pHzEbrcS
	 gvLGwXezfqCSBp7T9RLsP/84WRsOw5AfBD6XiehWbSEjXLUcSXhl1Nal5w2rdzUgXT
	 EOAbtA0vaI1MYRgSmzQ350GKQSTJjkTCxW/DY6+jriqojgcIj4WE+qCdRsSK8IWpPE
	 T+6aAryxe1BEukz8R9vhgJ8jSsC7M3feFKgFY++USOqEiU8ymT1QtpWoGoUFGAu6Uz
	 t12d++SVeBYvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7120660DE5;
	Wed, 11 Nov 2026 21:26:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F418FF22
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9EAA4016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b7v794-RhA1u for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 242F7400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=hV6kPQwJ
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 242F7400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:13 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-843cf077f10so4438336a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432372; x=1795037172;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bndDc3iegxWT8LdDN5XEULIE8/nRzjStPc3HeaLYAp0=;
 b=hV6kPQwJb9XbXvtume5oo9qfpY/OLrrrPZVRcX+U7cz/n1dCbr6YCAeernohBniheA
 OV+KDxOHO304DEqhpqd1gtnH740i7azjFMWAFEkaqG1bYmZnaMsyImgAB17lnkqBfejA
 DEXc95H8HBPevfj0T02NXPbMObfjb9Xk3uGgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432372; x=1795037172;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bndDc3iegxWT8LdDN5XEULIE8/nRzjStPc3HeaLYAp0=;
 b=0OF61ZwCr1xvii/5jDOBGPNhUwi16SSjxhKKTH9ck52NTe271Bz33MCjTkB/KNlL4L
 EC2+nK6rM6So5D+TzdmGEu+MM8/SXXKSIvnBK9gzEANHWnf98GaN9fp75TzCbmQKBImn
 rpZb0oKwI9nH8X0wKiVb7IHsxd6xAiztulTgM/tpU3rQCID3z8gwigCXjcFxV60u65We
 xAygReaZlgklkLcxz/fl6Z68DvryLeP6tpCjUYXR3+2oRSVCGYJbc+2dbsOf5FXfiKXG
 bfJEEqJ3V+gIOBjyli4HYg48m+mXBit16Bhn1iJiHLULpH+RCnG9IV5TE7IYQwkn/4fR
 0MpA==
X-Forwarded-Encrypted: i=1;
 AL+hErGLKg+LtkceCX3Daf/9OvuQdJHUMNnYwUWpu72OJjrLGf704FQlOqjO4TEEOK7ucqB3FdAoVko=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8L5lo5rzv+d3iAIM8NPasapvE97j+V/OkBZ+A1hjp/Xs0Q/c81
 9xBxPoowiXua+PTj6GNKeC897eb9cl2FiEu88j3X8fmZHBiZoFvXv3ivWtFQQDvcnb8=
X-Gm-Gg: AYBFou1v5b8QhvzSrpnDHvGWVSoSO0Dv55ZebY4Bbz/rCN4SrzLrsMR1KlJe6bid41V
 PFK8wR9638Y1aVg9epTbEqRt3GMzNmHb5ZeKmr9IBcamkoOVbXi7KZYMRz25WqE9Z3bE24skvsR
 lG3YhtFQGEI11Aj0Bglga2yTc7Ptp4WChUdDsf+kf6hkALX+VIe1JhNprTFa78gEeccdIo5+u2n
 XDZS3t7cdXdeZte5a6TXJ1fl5hAogs6tpM/aS1+cBBGqqJ/7F+xAalVLqt8buzuAUAkpLyXb8hS
 jm4UW5IeMZCQtnNJfTOOoqrvOSAylJq+2hQveyNJD3aFf0tDeGvF+t2HNkQ/su+PlXOr2b1W42e
 oBtp+uDzJVfgZ4yq8bRxHfI6dZgiUT8kCkA3tnmusbqMbi3NYXGRCixvZYicIEDm+bjGSEMxnZH
 s4WJIGku6iIbjRH46WIAsWfs2tQpwz9sBTGYWzkCwKiKOz5E6xJ5qB9XWjG0Izaj9uG3+5qmdL7
 dUeTFFwsdm3vmNeLhcrBAaaYvnF6dAue6q8SHnlmK8sHZPQ4ZWbzGuvwZqvuds+3VWQwyRHxpAg
 EDF5r/Jfm2jY2h5skwJc6FLEMYmVmYv+TE+DVBRhpOF48TxLQPCv0D3Oa/84noecgKYwktn/+vb
 CZxcDUqXo+XQ4zEAghy+2lHMvft0Z4UBGYDvyrNzS8x0jFyPfKR7yZv9z1ctfzuJcaj1g3uafVu
 d8C7pqss8y7W1eGRxV7CveeEj1JZT0ng==
X-Received: by 2002:a05:6830:3489:b0:815:40bf:e777 with SMTP id
 46e09a7af769-860f287927amr3673714a34.13.1794432372528; 
 Wed, 11 Nov 2026 13:26:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>, 
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>, 
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
Subject: Re: [PATCH v3 00/11] imagemap: structural and cosmetic review
 follow-ups
Message-Id: <179443237165.664252.4581080196548288088.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:11 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 31 Oct 2026 11:09:30 +0000, Daniel Golle wrote:

> The clean-up half of the v1 review of the imagemap series
> (cover.1787272661.git.daniel@makrotopia.org). It applies on top of
> "imagemap: fixes from the v1 review", which carries the correctness
> changes and which several of these patches touch the same lines as.
> 
> Patches 1 to 4 are self-contained tidy-ups without any functional
> changes: the suite list put back in alphabetical order, a derived size
> for the header probe in place of a bare 64, a corrected rationale on the
> imagemap_lookup() guard, and test locals hoisted out of an anonymous
> block and a mid-block declaration.
> 
> [...]

Applied to u-boot/main, thanks!

[01/11] test: cmd_ut: keep the suite list alphabetical
        commit: 1175aa343e278542d0c565a7e207faae2b5cc427
[02/11] boot: bootm: derive the header probe size
        commit: bc413d518883f268247cff5dfd3d40263c54874d
[03/11] boot: imagemap: correct the lookup guard rationale
        commit: bb835b7c0144d4649b85def8d1728ad0d6e16a62
[04/11] test: boot: imagemap: declare locals at the top
        commit: b265609b0f54a3987f95c2ae06ab3e0800852251
[05/11] doc: imagemap: describe the API and phase gating
        commit: 1a9e2e36d6339cfa52c56eb9d07a2b0ef7b92e63
[06/11] doc: develop: sort the imagemap index entry
        commit: 4fed07406053263b6c9f7ecae598baf9c396eab2
[07/11] boot: imagemap: name the device after its partition
        commit: ad107c4e187b8183084f7907cd37f328ff109d78
[08/11] boot: bootm: set the imagemap from bootm_start()
        commit: af9743aa20b6b2c05e9b94c5fac0fdbf44e56c3d
[09/11] boot: fit: share the external-data offset calculation
        commit: 0348dbf9dc7996990c1007cbd35c50435a3a66ec
[10/11] boot: build the imagemap pointers only when enabled
        commit: 574d98f3986201662d8bc7cdbb9587b6ddb4f398
[11/11] test: boot: imagemap: caller-owned region not resized
        commit: 8b48b6479acffae1481c41472f9659730e44daca
-- 
Tom


