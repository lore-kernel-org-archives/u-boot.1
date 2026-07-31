Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368F6C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 09:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10DDC40F96;
	Fri, 31 Jul 2026 09:46:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6jzdNHl0aGW; Fri, 31 Jul 2026 09:46:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B8B840EE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785491196;
	bh=9yivesAPLGzv4FI27Y3VCleqM6g/nZnBJblSUWy69mQ=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0BJvk1Wz/aqM8KyBzBDtuLh+Zt9xDxP53c6utwDb8ipjMGmC7rmp+zMvWjCzrDTnA
	 d++khpagMkf0gR4xoTqHPkcX+SZ6AqI9Fh4DSs3sToB7Zknh3sxZh6saUBcMxi8Jdi
	 OiIjcCNZbRGf/DIlxGiO3Cu1IBspx56cV3coO1vkuS1mnhG/Q4R1loi8oEUB3LgiIo
	 NmwhRU+/F/jNSf7i2LW7o16QY21hSU8nPxm1GX8ta7rMHA3AYSvO9TYWMuLd5ukMwU
	 Ikr/f8FdNX5XUF9qpvyYKZ7Cj1CReJNRj0JqqywwVssxfe68OK8dZNcVknZqhUahIT
	 8xHN+x9nQHfCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B8B840EE0;
	Fri, 31 Jul 2026 09:46:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D450197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43BA7401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeN6BEPs-myK for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 09:46:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=ehristev@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8BF4340074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BF4340074
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BF4340074
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:46:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70D5642DBF;
 Fri, 31 Jul 2026 09:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38A41F000E9;
 Fri, 31 Jul 2026 09:46:31 +0000 (UTC)
Message-ID: <fd29bb79-5f7e-492e-b460-68f0ec8a1dd8@kernel.org>
Date: Fri, 31 Jul 2026 12:46:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PULL] u-boot-at91-fixes-2026.10-a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785491192;
 bh=9yivesAPLGzv4FI27Y3VCleqM6g/nZnBJblSUWy69mQ=;
 h=Date:From:To:Cc:Subject;
 b=VxPiQ5eWFdqCtSbz0G/jQduvbRzGQMhvWb7xu/78nLsx3I/d8xr8uGzb9CwIOQDNf
 8mOUHXOwIVSV4keJiV526W5NFWLtvcLjn9QhbMRy/5sohcHSD9Yp7C4e/KwYujjMG3
 BsULd6eSM0b0VAyc1Malmk4PY7a4dYIx7ekfondNFNAYrMvvxBbgXTT7pfipoXqr3F
 jVAX4DYSjesB6lEOypYLY4f2ekCyRpuySXugwrmxAQ9qdDDXpGkqaZHXSuWq0YUKtF
 0jnQ7rQIjryZz83lT4us9IEY1wBlgUnJ59hEgaSnfibJNf+u0JUo+Dj3QePEwJjCd5
 819MlgnSSCqnQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VxPiQ5eW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

(resending from the correct email address)

Hello Tom,

Please pull tag u-boot-at91-fixes-2026.10-a , the first set of at91
fixes for the 2026.10 cycle.

This is just one MAINTAINERS cleanup

Thanks,
Eugen




The following changes since commit de02bc0eccb76aec8272abed651c35ab120f4844:

  Merge patch series "i3c: dw: fix slave device setup and probe issues"
(2026-07-22 13:10:22 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-fixes-2026.10-a

for you to fetch changes up to 88386697bb752f0321f1277ebb92e8f405b4ba45:

  MAINTAINERS: Replace Atmel with N: (2026-07-24 18:48:52 +0300)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2026.10 cycle

----------------------------------------------------------------
Marek Vasut (1):
      MAINTAINERS: Replace Atmel with N:

 MAINTAINERS | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)
