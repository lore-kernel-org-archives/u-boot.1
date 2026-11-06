Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23CC606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V4lcLVti;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=T1JM/KvQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8B57608A5;
	Fri,  6 Nov 2026 22:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F6fuH1tJdTx7; Fri,  6 Nov 2026 22:40:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2670608B7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794004853;
	b=dTIxcgYHv1XdIkY5s9c0NRPE1DuwzxIfUXxIIu/PyyvXEsyodjZMjtzRGFys86gMowhz
	 98pgRy06XIckPcwOtn2ZSAUsHnN5SIDSGOpd61O1qvLaoKtRIM7+7EDIz3sL2O9pcX9KD
	 j5hUibOOytwppSmVQ4VTQwZEToUf3e2F+SoBlTpq2hdW3uYKieqPP/cAlz45wPVJMHRPp
	 N1GwqU2aNtRN3CXxRW+ppcSZLYwu5QPTb0VM/PSbEqEIUlXotvGHyE/vM6LLZiKl71nAw
	 Oft+9yU01pHmYDCXVnpB8Q+UKuQws58KoFM74n094+acwbdhFDIPfdQeiSmqnTfpIDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794004853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KBszfMW/Q0Lj3B74ks5N+qjZz4KCqKpOdrAg/zCx3BQ=;
	b=CuAOgQDnB6fSHJ8uBe5w8ercaghWYLxlB9UAyp4tjoeqnyzEoBuSaX1sH/W74dvCEBg/
	 gldCUeoX+HKwU4YwY3btkER988hBK/pbZSFObFw26gfgTUpwd3XScbjrCZvJ/5IWzfdli
	 eqVZ4sK1nCriYK7CaZhLwJHmSnZO69wzeKYdz1pnwqiVtaXWt7dmRMVQMUNWLav27sb1v
	 k22+sOMCcyG+J58WeX/mUkhB4Ct5Sh4x1Gz2NtpgIHOOhL5rk7NsCaETUKcPQaPf/LMbI
	 dHYSEJJhSCNzbUKOfZozGtuEAXgz/qhHNvRMCLg1I+zBwIl36roRjkjDp/uT3NuvkCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794004853;
	bh=KBszfMW/Q0Lj3B74ks5N+qjZz4KCqKpOdrAg/zCx3BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V4lcLVtiIGoqkDO44vNsRcbYfJsD82pr5U1O1RqLILvVuC+9sOKLwKpdXWgGvGw3/
	 Htr/thx9tD43jsqgaNZnHbxuh1AvswoXZm8rBXbTGYEMhVYgVkRxHUj4i6zzGxMai6
	 XVohikTTwh2j2nLbU9ufRYlFJtMptTWhANf5DLgxdlK1oF2/0euw05/71Nr81kwuha
	 hjhFPJcGUP5VdpEFYCNPEe30n6rWbAme6OQotymGjMxMhMzx3BbQKoQcRh+Fprg5/C
	 hxjtUz4DPTvgMu+Tu2eoP+fpUiDsalSbWh5YwqD1g3XCCVfjQNhzMdZfeMGP/dELhC
	 pbRWb6TeYqzXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2670608B7;
	Fri,  6 Nov 2026 22:40:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4278C2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2890740403
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqIu0KcLwlMi for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 22:40:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D2E9403A6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=T1JM/KvQ
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D2E9403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 22:40:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=T1JM/KvQ6cy2wnDlwyfy075Eg2r94jH+FavnbD6bJGV44F52g3Fe1HioTp2Eaa4B8LIAmUlvDOYDHGOJa7vZ3op1hm+axpRM4jFH6poJmJJYtQlsPaNXWBsYjfmz4G6k4c+dwPglvWV31GUVaXm5nTDq5e7i28tSBtVCfnfmfaM=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=KBszfMW/Q0Lj3B74ks5N+qjZz4KCqKpOdrAg/zCx3BQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794004839235145.75727228338712;
 Fri, 6 Nov 2026 23:40:39 +0100 (CET)
Date: Sat, 07 Nov 2026 00:40:38 +0200
From: Igor Velkov <iav@iav.lv>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: iav@iav.lv, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/4] net: lwip: wget: accept a reply without
 Content-Length in the size check
Message-ID: <20261107-re-heinrich-wget-blk-1@iav.lv>
In-Reply-To: <7fa987f6-0e2c-4926-a1d2-8269aa096ff6@gmx.de>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <20261101-b4-wget-blk-r4-v1-1-e27a009e4043@iav.lv>
 <7fa987f6-0e2c-4926-a1d2-8269aa096ff6@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 20:14, Heinrich Schuchardt wrote:
>> +	/* lwIP passes U32_MAX when the reply has no usable Content-Length */
>> +	if (wget_info->check_buffer_size && content_len != U32_MAX &&
>
> A constant of this name does not exist in LWIP. Do you mean
> HTTPC_CONTENT_LEN_INVALID ?

Yes, the same value: U32_MAX is U-Boot's name for 0xffffffff.
HTTPC_CONTENT_LEN_INVALID is defined in http_client.c only, not in
http_client.h. In v2 I'll move it to the header and use it in wget,
which drops the comment. I tested the no-Content-Length case in QEMU
with a similar server.

Igor
