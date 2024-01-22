Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48BCC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34DA4879BD;
	Mon, 22 Jan 2024 16:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705936802;
	bh=/jD4VR49GbyoImCRckqxS3ZsECxYwhI079fVXx5YMYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NI8/QGEjM83IiC+R3UDJEehHpgvBgrCOYY9F9OJDLkbP+hkXavj4gZ22dGiLSjEtN
	 QAdZUJt6uBIRaYrrT7CY5w+FVbLaf4db7GFlfH/aPLSf8d7FdjNhaodF5mKEoZebtA
	 QxhGggqr+TuyZt74ghyefnPWU7/oNxLhpvofWuj4ZG9WNjn3cbvwatS6dNwa9Dx25P
	 WVd6KRXbyIVfh2/S5DY2PEcdgijjHaYcVss+1U7oblpxphZFLF2baUohaqesP51RG1
	 SaRlSe90az8R7djWPJ8J/zX73y+5o7B7IwaGvDA9pyuNXTo97rYz1YczQZPcfgwuGu
	 WL89gMVDfg/PQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC4FA8793F; Mon, 22 Jan 2024 16:20:00 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 625C5879CB
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TJYmr0vHtz9sNn;
 Mon, 22 Jan 2024 16:19:56 +0100 (CET)
Message-ID: <b5abdde1-3087-413a-a8ab-73ba5f2dcb85@denx.de>
Date: Mon, 22 Jan 2024 16:19:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] board: solidrun: clearfog gtr: add serdes
 configuration
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>
Cc: u-boot@lists.denx.de
References: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4TJYmr0vHtz9sNn
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/12/24 14:35, Josua Mayer wrote:
> Add missing configuration options for clearog gtr serdes:
> 
> 1. select between sata and pci-e for serdes 0
> 2. configure serdes 2 for 2.5Gbps link with managed switch
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v2:
> - change choice default logic to remove kconfig warning
> - Link to v1: https://lore.kernel.org/r/20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com
> 
> ---
> Josua Mayer (2):
>        arm: mvebu: clearfog gtr: add config option to select serdes0 interface
>        board: solidrun: clearfog: fix serdes 1 / eth2 speed for clearfog gtr
> 
>   board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
>   board/solidrun/clearfog/clearfog.c | 19 ++++++++++++++++---
>   2 files changed, 35 insertions(+), 3 deletions(-)
> ---
> base-commit: 2ee7a8ec6f1711abe9619fd8765edc16742be9de
> change-id: 20240106-clearfog-gtr-serdes-8a927f496bda
> 
> Sincerely,

Applied to u-boot-mavell/master

Thanks,
Stefan
