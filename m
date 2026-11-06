Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82885606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yFg978Tj;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dsxp9QVv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7470781108;
	Fri,  6 Nov 2026 16:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akzIwpAlh1lA; Fri,  6 Nov 2026 16:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78AF280F75
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793982436;
	b=JGXV+/2K24c2W2lDFjizq0F9XRwLidVVKs9f8Cft28Zt0UedqFG9rHxXs1Wl03RS71An
	 Tf488g2BrWm27DM9btH4hb7xTILE8OykeaujhdetdOelisRD0cu/4+A5GEyHWJpG7lmvx
	 jvSnHCFDm/ktzKBthF3xlJmm8veizcSw8wG3sy7BI7VhYaK/DdCbsJrbXdFKR7PVFte78
	 UrT4w5esr0Ww7g4xMieiXWkH0uxmSLmRfYFhBtD07FvsRov6GMVsXxVRnnJT6SG+mN1Wa
	 3XzLYZc6hOo2Tke8JWHPdmS80HBpSSuseL6XkCp58f3k1UpEAcQcnurLJV8q6jF6a0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793982436;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3XY3G9lYU5B2XnTFa7I9xbuXP+8NMkmepjwVCVUsylU=;
	b=oiT/W8Q67zsqPASel8DrqbvDtJpRZypiNEVzhy9om/PypOsSarA11FM+qn4zInCyrEj+
	 1Vym9ZqNlBOFmhkKbO1BCGUqVvkV3hLQV1jlbogB5ToQe4M+aR//PnEdDMWGP7mfAmt6/
	 A95Z/CsIf0OBuHeUNUVq9uVCUHdIsb/T/NAxLX4uSxe11tSTBYF9sxARF8EJCW4wbs5qy
	 cnIlw1Ts72tpg9NwD7pgXw+NOS8PholhXeAMpAFUfkPKWM4Svnya9I48MJnYlt/gg+/Dw
	 9svHZiD+PqmLuvcd0yT7T0jJ+wLU9j/5h6QOf8vM1jUddwUmt85GYNoBWi1+GMXMHQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793982436;
	bh=3XY3G9lYU5B2XnTFa7I9xbuXP+8NMkmepjwVCVUsylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yFg978TjfSxtqeWdKSsV2VmEqcSJ8sPuwrYWnJuuT/s5mrUjbJNVtVaU44c4OiX9Q
	 AWMzYk0RjR05cKkYh1yy2cdMFkTwu6sO9PGem+YHO4qXCvKG8SgpsMBMLwE5K+aexE
	 G5a+IDzRt/gRBTJy2P3jFNlUHRDGz5D8NHKbtrJDvd/YLLEg8lw6ctvslrINMBmxaA
	 vH9U+PhZihpOD8Q+XCEWIFyXwMgGsCNXX3EA+msdFJcuf5dOiyx5cmaLahgXI0TLAu
	 Q3WHc2V89YK2MMc3luoomZMvFSo1Xig6/l0w87qT8dwdKOPrlYRPjGemGqMI7nJx+L
	 mTZN421aTZIKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78AF280F75;
	Fri,  6 Nov 2026 16:27:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31A6A4B8
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 184B540607
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7u-bcW41M2g for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:27:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9A0A405ED
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dsxp9QVv
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9A0A405ED
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:27:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jLl225dVqzMlc9;
 Fri, 06 Nov 2026 17:27:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793982426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XY3G9lYU5B2XnTFa7I9xbuXP+8NMkmepjwVCVUsylU=;
 b=dsxp9QVvpf7JLRt/o7CsN+MsGZKu1vR9axEdq86MD/+qT8hS9NbzVvFQ5doLCufMUIUrKS
 i9ZTgSYvQDmyvsH81PFCKJY85ovZxphryiRSVGn58F2ELgRpMoBDxexXBlAUf5rlZzko9Z
 Om/fdfQQN+hmVuUXdhOqhxQyOWaOxPWZYq2YPO03S0IG58fgJsc4NBMn5n65Z63EeKuSJX
 /Xt/rJJaz0fZozfyiQAlvn5X2FxtK/Mfy7ujFYE1CLT/joPtmUODRlsVu8udRS7MWes+jH
 5DULyObGiDBewcSDz570135llCVQe8i0SJNRTNRgskwZ3bt07RqesjR4EOqh2A==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: Re: [PATCH v4 1/3] watchdog: Add support for i6300esb
Date: Fri,  6 Nov 2026 17:27:02 +0100
Message-ID: <20261106162705.901372-1-stefan.roese@mailbox.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ac8707e106b9fc91326ce64d983e9b12cd0a61a3.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
 <ac8707e106b9fc91326ce64d983e9b12cd0a61a3.1792320756.git.jan.kiszka@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2a8b2b4d48f7e85cad6
X-MBO-RS-META: nq6czuaed77wbwpgienyhqru3rcpiz3w
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jan,

On 18.10.26 12:52, Jan Kiszka wrote:
> While the real hardware might be in the museum now, this allows to test
> watchdog integrations against QEMU virtual machines (-device i6300esb).
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode

[...]

> +struct i6300_wdt {
> +	void *base;

Nit: void __iomem *base. I'll change this while applying, no need
for a v5.

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
