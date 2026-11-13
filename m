Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CD606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UvHEPgyn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S2tRhVvs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF51814BC;
	Fri, 13 Nov 2026 15:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DgGb8KnFkiGu; Fri, 13 Nov 2026 15:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 602B0813CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582494;
	b=rJf+Es/HXsXVHCwMDbPI0FX5alSOmbkzpuE9BlYRiHAUbpNklLYJmCxDcejDF6a1qQqq
	 hryPVyrKlCSRkBxNEgDC7WA+xMfkvnSJzDsF8+tT2VkJC6pkZexCX+9rtXlf/Z9rNsy0U
	 M/hFRJnbCRVSfBZ6g4NDpNK/ic/Qmz3CMuLrOjlTvJ7K5c6Ff6F6tU2H+bv9DvqxXkmDq
	 cnBXSXbokeFHvkp0ihvHh8htETDFz5weOaoPFpTUe+OXITbaeM4UrZCkn2iWbpc4MBFXQ
	 ObGcfu4XENj1HluSTB0xHYrLajbGDkhLKvbCBfx0mOlamdG10rbMIiOO5mT7rPa1lnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qb0cBgmhQ71WBakU650rLr5zUEXMlixcWIhjLf9tWSU=;
	b=MIWAnWgUbloLCN1nFACnnuw33/HB/tUmr+a87Dgn/048VaiEq9vuS8p4f+OyOqUfdvil
	 HUmQMxnyTBpW7jNRFYHM//22sbTFyvR/ZuL/OaIg98Cdf4cZzo9n46WPkLjW9vqzq1Qcl
	 fXJdsRAIroNqzMwwykXhleDF3n8nMmiPpPVVOdWxRQRuFVryMLcchgIoHTqkr+SVnSZmz
	 iWAqQLohNC+R14UlNn5g+ZMym23h4AC+UoaUo3RSLKIAtd0npiUPcjXmS9/1kePQ+IN4j
	 urZCyi/fUCfIjadJmvSfBL/IEwZtuq6Tab8L1yNjH5DFVfRMjxVy84lm4uEC2NuLs3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582494;
	bh=qb0cBgmhQ71WBakU650rLr5zUEXMlixcWIhjLf9tWSU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UvHEPgynBKk+Q/bFP2J/RIoz+5RnXq75BUzcc/IvERpcfU6NPftbW9l8u9I/wLVWt
	 LPa00XKjvxb+M3i9ZzRVQzAUhhEbtMORYQQ3RVkeoUqES6JzmlGM7Hn9F+g5KkbvY6
	 8bt0Xll45PljGtRG3AD+ih7noaM8xKJI/TIcOG4o7m8nxOdF3/zgRcfdShB2zPN2e+
	 l7FGRhPIJ9Af69AZAiVo4GB+1NcgucwWt89cfAkcdtyjF51vcQoRrFujmQ4V5oWowt
	 TAh7iTRtYAf3xPHMtAyoyeFpwtUY+LzNFjS0Uv6Lmr7Bu7otV/SuOU4IY+Thf2BKld
	 NHdw2TlziPcaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 602B0813CE;
	Fri, 13 Nov 2026 15:08:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E4259AF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9B9C40902
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AT8zM5vlxgX3 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0AA444087E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=S2tRhVvs
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AA444087E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F9B339;
 Fri, 13 Nov 2026 07:08:06 -0800 (PST)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC3A3F85F;
 Fri, 13 Nov 2026 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794582489; bh=7pxsy4mFi3Zt6dLSy9kSx9G/hZYLShYY7Hyd/iXgUTQ=;
 h=From:Subject:Date:To:Cc:From;
 b=S2tRhVvsTrIJYw9BL87PImcQyYulrfIvwwa3Z3dz08WutU4V+5kHUy9tySM5yxthx
 zGtcPszxy8xmYJjnFTOvO1gyaZcajAfFL+y/Hg4cYm+CoTMEFuLUNIyFR/ZV9k8Ml5
 glMcuPmNqzERv1r1VpDSloraL4nh8t1YeqXCIeic=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/2] efi: fix and verify variables append_write
Date: Fri, 13 Nov 2026 16:07:55 +0100
Message-Id: <20261113-append-v1-0-4cb63d522562@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDXpICKuIhZMB2NRTYtIpHdXL
 L/kf++GwF44QJvd4PmUIJtNwDwDWgY7sxKTDIUuakQs1eAcW6OQJqor0qxNAyl2nie5vqOu/x2
 OcWXa3zXE+ABSsZeyagAAAA==
X-Change-ID: 20261113-append-1cfc64c0e0d8
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=7pxsy4mFi3Zt6dLSy9kSx9G/hZYLShYY7Hyd/iXgUTQ=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBq9yfYGmON+3JRv5rvxdda4xOFuURovr8Hw7pvF
 J/u6DyYTT+JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCavcn2AAKCRDLSfhWdqMG
 lEfbCACxhpCvrcNoKdqhKmcKiGn0w8of43G5aUxtwXxJicq8Aag09bdZuEBBBfruuIx+ZsTyZDF
 8hu8bfHMo5vbFtmiVmS2+qGILH+oc561h3INTXDUFsBjlrMc/T+Q6hCp2G0TH6j3Jp8kBUGWq69
 0WZEYPDVgjIGJ/Iob8Vu3+lrUU0LfUsWqgsh5bbA5HNQabWy5A6kEiav9gZdbIG6LTn0T3OE1De
 FCIilWLeUU/X9N7elhm4GpMaZGYxIk7D3yTgFmHNVwwzc4BjSZhYHMFG6rtIx3FCvStELGkjRGg
 qsjo//B8Gt/+L/RT3Qo8MSRVuLzgwxsD2bqlTIfgus4ZYaj/
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This couple of patches does the following:
- Fix a corner case of the non-TEE SetVariable(), which could record the
  APPEND_WRITE attribute when appending to non-existing variables.
- Enhance the existing selftest to verify that the APPEND_WRITE attribute
  is never returned by GetVariable().

See the second patch for the details to run on the sandbox.

I have also verified that the selftest changes do not harm with OP-TEE +
StMM. (This hits other issues with QueryVariableInfo() but they are
unrelated.)

We could reasonably reduce the test to verify the attributes only in the
cases where GetVariable() follows a SetVariable() with the append attribute
set, as those are arguably more likely to be buggy.
If this is preferred just let me know and I will send a v2.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Vincent Stehlé (2):
      efi_loader: prevent set_variable() to record append_write
      efi_selftest: verify get_variable() never returns append_write

 lib/efi_loader/efi_variable.c             |  3 ++-
 lib/efi_selftest/efi_selftest_variables.c | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)
---
base-commit: ff8a9bc41e4e5bdd3406932af5abb4c18064e539
change-id: 20261113-append-1cfc64c0e0d8

Best regards,
--  
Vincent.

