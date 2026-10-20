Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FC606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ndRbWw6T;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5TuHD/9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 599F06075D;
	Tue, 20 Oct 2026 07:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8RvIWEWecjq4; Tue, 20 Oct 2026 07:38:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EA48607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792481893;
	b=A6kP8krkhnSlCTfCPq0ml3O08I/x9malvV2M/JLveQRsxryIRRhkqv8ZJSNhPHJBCxoW
	 EvHNzaTR2tdwyQzvadkszbcR32pfUGbfXonfYhTv5sV1nZ/RZ2HEP65zk+uvTloBnNwk1
	 cGcnwY+g8d+8kf6BWWrh9dEe9TRXy8fbXDoYxFuKuYFEcJrzzRHhC5oXpwMJzv5gRWIGX
	 3nh9DqDDB7fPOtzV4/UVMB2Mj5NtRqrcMrdaijPo/l2EJbYNDKt0/I+LojNUqkm0emVk2
	 nkKRty2hNh6hz+MzcsjHA69G1H087+i10WYU522R5is4EdKezK1jHYhAn1Sjwx67AQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792481893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EeZnzRA/gSw8zfn6ye0hzkMSuAXjCrYCnYWsJUwTNqw=;
	b=YCg14X6NIl5VMCfkt8LwAnhzzcmEoZ2obl67jm4MmWvDSm1ZoUZBcd3TiDHxpIRqjCvY
	 dnmQIusQZZ/dbnknh4malkRIqyOUtXLfkGRNzNtFM+UA70vlFFA4t5n1J54U2c7Rsu7w9
	 7rXnkOvmLSEhUoPaTR/3SxzWS9M4qwU/Eazr0Ldi/jibeGjQgEmF+uSsEJAwUsSNY3BZB
	 t3SV9PZE8FmYBsh6PjNAGGihfGhVAOy8sguwJ8MMGWQgAexbmVZqF7nwn3JmINu+qEAcr
	 xywXXto2aUzRXWR1t/xMN2iPBTxh1aeNuDZWz8QI1fzAT87pAkJhxUR8kEJNvXCQEBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792481893;
	bh=EeZnzRA/gSw8zfn6ye0hzkMSuAXjCrYCnYWsJUwTNqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndRbWw6TWlJxsYu3L83aUSHMwQkKJSDiEE4eIOQkq6Hzjb2FExAEHGXG/CdiLPSIW
	 OBm4/L8Q2rLRhY9qVhErkg9LW2lGbIgMlt8FHbMMuKNkUA1/EE/3dNslHs8QdHaClw
	 nRSACG0PvFhbNUchZKECzoBui8u55+Qe8dLGDA3mrIb8KPul9h3pVNBToPIy4ePGXe
	 XqkNKj4MQVx8YG3kJ/Ls75Kc4IaWzGvBm9+OPWbtF2v5fYiXFEmUvQ5CVIeuMyr8Yv
	 3iF8hXkK5BOuooGC+sjI0AKWyWOule5zTerD1xxXP5pC8fO7zZSs5laszn4zqLiEUp
	 tTzbaDGEOoIvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EA48607ED;
	Tue, 20 Oct 2026 07:38:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6107D23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F2F940817
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JRsP2UXTkDsS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62C3440812
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792481890;
 b=lGjPC6HvpVpRvJCmeWAmdiAuMG1eYtelKLpGhA50dcH1MX5JppZGSWg10tngs3oqExKs
 u73g0S/a8WALAzRYwc30R8ZTUxroSytAqnv68DR0NUpQKqweiUTaMCa7FX9tUU9l9gfAQ
 2Jf4in1qVtPa92jNHI0fxhgOKvWuSZaToUGZibOeQ4BIORpaTIpR324q0Oc0slVJwp91U
 YThjgJNc+6TNmMghXmKnJq9Efo1KpOAkSimN3rvBwIc+D3tsIe6HK5Oq6YN+6LOl2JZhp
 1gIC/Gk1tTkAiQXEiUCpPnOB6PQOFDfm6yFyFo0pfKl28hjQUp599pYe0hZiTwK0dZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792481890;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=EeZnzRA/gSw8zfn6ye0hzkMSuAXjCrYCnYWsJUwTNqw=;
 b=kFlMD0660Yz6f63oBvv7Z0xMV5vSYSbkKVE8Dl19+aO/ClVlF0cCLH5nOdtdA+6Rt+q/
 mjBKOYlx3ql44HhXeIVntc3A/J5LgTY/szzrVvGjkQ1ZzSLmnmdcKoEiGwY3mPUpCL2op
 qDpnm84wqWBcybcMRrWNgrETgN239e+UBaRiuHPv0oPdka7OoNP1EZEe7mt6QhF4SE21s
 LUsrpF9P+b3gtMWoOztxb/Pp12y/yHtwhoK/CBM4Pqom9uzFx4+PVkmHQtju0pkG0JLJI
 sF/fjYm3YQL9dReAhEpZEOxiGMdHqmB/WYFkVTgWZfaYMw+pxYKp/1ceJf0Y0yOflLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="A5TuHD/9"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=A5TuHD/9
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62C3440812
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:38:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 976F760A59;
 Tue, 20 Oct 2026 07:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D077D1F000C4;
 Tue, 20 Oct 2026 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792481888;
 bh=EeZnzRA/gSw8zfn6ye0hzkMSuAXjCrYCnYWsJUwTNqw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=A5TuHD/9K3U7aJLSBCoJVUoa5Jm1e0KLUEwFioWhTIp7zmfSPbh9A/CoWOzOnz0kS
 4EkPIsPNSC+QmgIOSsyDm+0KU7ZoJxrLIn2AjtKVrPnMEkxpvU5TuKJ3Rz/uC/TNrl
 BLCt5ijEbThMbJSJWBvvHrLt4FjyAYGuol7JyrA7asrXB2xyY5F6iacm0/OvZe4Cmm
 PtNWQsaEftL2LLq5HTml82FMykJwdiqJWZgRGkWtL+Yg+N0PV8GT3FUaWsFiP0p1w5
 9Re2FFE6x9DuGhI5L5HmB4BG4yVfOcFxLEYUXB6AypaDDOijRxWTkoQRUebppXWyKq
 odHGfAtSJLLzQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-1-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-1-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:38:06 +0200
Message-ID: <xhkdb4ieg6cv5.fsf@mkorpers-koolstof.csb>
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

Hi Igor,

Thank you for the patch.

On Mon, Oct 12, 2026 at 22:25, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> write_pvalue stores its argument as a NUL-terminated string, which cannot
> carry binary data such as the 32-byte SHA-256 root key digest consumed by
> CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
> hex-string variants to provision and dump raw persistent values from the
> U-Boot shell.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


