Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CB606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1LbDuGWr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9guzxUr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0581281067;
	Tue, 20 Oct 2026 09:38:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2bm5zcDdD5Y; Tue, 20 Oct 2026 09:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05A6281066
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792489111;
	b=g/ZAepqbBPQQo0B+/D8tbWPyRleMbpRSyZKWrT5RTcwNQ5NzVwhjtK4kXn1RUcWmrEbr
	 P5Rkfa5mDgJrPKTXdApQatEaNznrp7VDxFZ6PQZW5OXUmUxG8stpQ6EtzJZKPELqbmz07
	 gNBdDFkrP2Pmax0INsUXJwi8Z73pV/a5F3qyNMWmw1zVhVTCZTQfQqyQnqnQwvh5gGjll
	 QNsqxnmWYxefdkK/YNKvov/V99jn4ENOwQC3YmHh1x6yjIANA4XZ8Tj38YmbPgpTp5ERX
	 +MClIui3nNhPYwZ+Qwi35S2r272NTQw9SvwMF6Qd4ZbKXEYSzJN9Ul8KzRyXFLdoUgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792489111;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GC0RZbiLv7Al1YY2MXByMbeWCj71hkx+3kLKivDr5ZA=;
	b=T529wJtb2KaxMg8Rx+eH+mJonLjrDNVlM4B7IGZ91es4ANPB755YR+2J7X2RJcHUTxy+
	 t3MdmR0uuTQK/zscBJhY8U3miOI8t5nu+iOJcjNzA5N1ELKfdxj4KxkxD7xnOstuyd5ST
	 aK9zpDoKv48LfenNGKtaEVPqfdgl8f8D3e+w+4U6gQiMw7Y1ZkbQUO5XgRHBFOadJ1hOW
	 URthLHQ+y5QC3lbIMp0whAEEbdr7pL15WhlpPnFNfMU9sd5uZqi9e3k6tpKIMtF0NvQrP
	 JmLheG0ShmEB5WzxycXz/C2dNScD9L0A8DC49iSZcogWpZscK/TdH1SMELvWAa8UNKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792489111;
	bh=GC0RZbiLv7Al1YY2MXByMbeWCj71hkx+3kLKivDr5ZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1LbDuGWrmzOERP322Pp4OI2Z9R2g2hMmAqQx2d5YBTRo2JLiaHPCL9xbLRb0usXi8
	 ZLcwCsGmigdVdm7Hofp8ECahq6Lcnf4nlLUY1q5lyWS7gDgy77WFScUNcXjss4bFTu
	 OyU3HsdxS3ADwi0/cGdLtDgViSWBhrSUVQUU5cJPUDlje+oEmqIPb0zYpzV0ufo77q
	 PuEAXSLt1HWaBNp+RFNtBJ9VC68K+Hk+Dk5APeSfPHFsufx2OUMM75q6zySXLzzSrZ
	 0k2kp7Hwc4FwIXGUAtdAQtQdcpTpZ07msEAPmCpDZWO75qNqxBvBj48VMy73ViUW4v
	 25sOw4KpP3ysA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05A6281066;
	Tue, 20 Oct 2026 09:38:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8AE465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1536A407EE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:38:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cXwCuLmicPIQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E8F1407F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792489106;
 b=L54GEIvncihh2fIbOjbK/TM2fyrFkdvlIvpoJVUWhPZd7UblQecToTcpDcelcnIBzLKr
 XHF9ZirmgrQwMM766tOHGGsdIaJT1IEG63vfYqtujwydjDVoj9GVcgQXe0c7mtr/2o2p+
 R+HFb6TIfiiqaKSL43F5OaG/FmowT3ZkmylGSV8dpfv/M7jwO4uWFF9+wGFjtt1gcPOzX
 7jAzTW6hMlSdm63VqUG1O6MnCEM1cLAxZ0qAF3jRmqNt0BpwMNmVz7YySjeBwh8aEwTtD
 7fxPXLK5uYBrk3nrrpPE606sWPDcNZx7Dvih0Ncsg+g0Vao40kTSQAC+UAWMtFb/mgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792489106;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=GC0RZbiLv7Al1YY2MXByMbeWCj71hkx+3kLKivDr5ZA=;
 b=JFEQD/YOG3x4c2sqJcEFwqWe3ApHBhHCN0+di8AB+kD2MP855q0SuXcqiJGA8I32YVjK
 O/XMHSYaGD9LScXmyAFlE5K8ZHhtNIHMco82/pO0LG113yCs2A1jufzAu5ZF3L1UMA4aS
 OG8l9wVQIR6X8BOEsDBZP4j/is7oNO7nAEolYA+MmsqAhJOU2wbfthRuLmBJlM/13C+4T
 PXJchtFsnncKX5DgVWUh5y5/TRlc06Ef8Qym/X3WUHjQgANqoRwPemnjQUYbHsdho2e6R
 xJSXubVZR0O020H9iLtymF8J4AtwxaCmtnHDfQzPFsAKEZElpuWhjNR2qU54Wu9bXGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f9guzxUr; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=f9guzxUr
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E8F1407F4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:38:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C27360A59;
 Tue, 20 Oct 2026 09:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C891F000C4;
 Tue, 20 Oct 2026 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792489104;
 bh=GC0RZbiLv7Al1YY2MXByMbeWCj71hkx+3kLKivDr5ZA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=f9guzxUrh0uP7N35puCYnTRRZbURzSIA2eJArR22XMamJA8J9ycn6TR0spuhr0JOL
 86aadOal/kcUyeRfgHAjasu0iDRnWiutD93GhDunzTaKxQ8CbgCzxLH5A87tjEonc9
 ns2jNhaFuiwCdc0kGrIsjCmpxnaecR5YCvFd7HuBbwOjctJP9+FnXT8OyDcyy8nwon
 RvVlxkgrqUt138aXYAaTdOx929AGvUa9NpwKrHf7vrfrH0jLs8Su0jqrJ7yvjf4bDY
 ZXV/dP683cUQXyytf6R0uqZjdo70io3IB/vtzSsGnoebYu/0I27h9OdSUoxYW8m8El
 k+pEwI0eWH9eA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, u-boot@lists.u-boot-project.org, Kongyang
 Liu <seashell11234455@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 uboot-stm32@st-md-mailman.stormreply.com, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH 1/2] usb: gadget: dwc2_udc_otg: bypass debounce filter
In-Reply-To: <20261008-dwc2-iddig-fixes-v1-1-24c302b8953f@foss.st.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
 <20261008-dwc2-iddig-fixes-v1-1-24c302b8953f@foss.st.com>
Date: Tue, 20 Oct 2026 11:38:21 +0200
Message-ID: <xhkdbh5ig4sqa.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Fabrice,

Thank you for the patch.

On Thu, Oct 08, 2026 at 17:37, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> When using the A/B session valid override bits, also bypass the
> debounce filter. There's no points in deboucing, while forcing

s/deboucing/debouncing

I can fix that up while applying

> session. This solves some connect issue seen on stm32mp1, as forcing
> session races with the controller initialization in reconfig_usbd().
>
> Fixes: 5739ef2bcb6d ("usb: dwc2: add "u-boot,force-vbus-detection" for stm32")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
