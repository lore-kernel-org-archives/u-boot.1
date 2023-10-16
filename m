Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A75CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 18:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FC9865ED;
	Mon, 16 Oct 2023 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ndUC0E0H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DvJWSKVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A72E86BA4; Mon, 16 Oct 2023 20:11:14 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF55865ED
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 20:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S8QCd4BZKz9srX;
 Mon, 16 Oct 2023 20:11:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697479869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfWxbJA+kmcBdzK9iT4HV8gkPYtCreZ6rYsUOYrgkQw=;
 b=ndUC0E0HOIQZPPAntl9BpBgrSvayOBWKAVrh9QMTG+mzffU7bZbgkH77oh+wgO0zz7YlmG
 61WiR47pKNzHz4H91KyP/h9gbUgu+nxIyPQzlKII3PxWjxYjyasX3xYmbKULZ/WEg2yuqi
 +yFRIRdefwZeIjxvu2/rn03nSyS5LMPlDW+xlf6fT8W7MG9hJyk87iQTNsEsCsd4eho4fG
 OPW0dUelRyGa+/5nAd7zHXNz/tAzdSzsrOC65KD4Ri+VOhWMN58ULymqDBQWQjbKj9tFfH
 YZZZapDDQWB/HBUxuZE5INpXTkx9gDO0lm2UtlJLmymM94yWXgz8lW5bn2e8Ng==
Message-ID: <39b66dd8-7ad1-47f3-b129-e6666c408aec@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697479867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfWxbJA+kmcBdzK9iT4HV8gkPYtCreZ6rYsUOYrgkQw=;
 b=DvJWSKVAP21yq/ZEqqlYg0Gn1RMIuHYnT6xbOmpJF+NrxLyFDOTjHOtB3gtcZPpQYW0a9u
 hJoWqXC6r5+aRkXEhRBApQSKU6ukoJPVjdNsIMNw8kVHt3r5HOJI3vtjnNT44Z/JeABPNZ
 FUDHEoW5KGCr4qmt9uyJqOz1EO6DRLNGc9vGJMqxKI8HKgNYOpTI5UvyWdEEgvuyKN0KTZ
 95D90XYSG4wRuWZq9HTjBICnHIz4s5I+A7rilrD6oOYyNGO4y7jpDpZUvk03ZVWcAkwxBT
 mYQmzlqPb3vZMMUgCpW0YaOJvt6Raq0qM+3rt/4NbzzjdctZe3O+pxSqXW5X6g==
Date: Mon, 16 Oct 2023 20:11:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/6] sysinfo: Add IDs for board id and revision
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-2-detlev.casanova@collabora.com>
 <f0a97e3c-3a9a-49a3-921a-0fcbd2aebd93@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f0a97e3c-3a9a-49a3-921a-0fcbd2aebd93@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9f46f3ba69b6a96bc09
X-MBO-RS-META: kis5prwxudrx4umooycsn395sf6tqjso
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

On 10/16/23 19:37, Heinrich Schuchardt wrote:
> On 10/2/23 17:20, Detlev Casanova wrote:
>> These IDs will be used by the sysinfo command. The new IDs are:
>>   * SYSINFO_ID_BOARD_ID: The board ID as an integer
>>   * SYSINFO_ID_BOARD_REV_MAJOR: The board major revision as int
>>   * SYSINFO_ID_BOARD_REV_MINOR: The board minor revision as int
> 
> Integers will not work in the generic case. E.g. for the VisionFive 2
> board we have seen board revisions:
> 
> 1.2A, 1.2B, 1.3B
> 
> For the Wandboard:
> 
> B1, D1

Dang, I literally had this in my upstreaming queue today, so, sigh.
Dropped for now :-(

-- 
Best regards,
Marek Vasut

