Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3581606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ia43nQbl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/WUhhky
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAB564090B;
	Thu, 26 Nov 2026 10:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vH_noWt6w8uR; Thu, 26 Nov 2026 10:47:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F4794090C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690030;
	b=p0biQdKGoIa4oF1EN7NIxtCaZAu2k4zzPUcJx32s5OoBf+JlOS+ljDWm7QiIzTQxgiCJ
	 gY3qF7YFjWXqQFrI86bMbBwkY8I4FQxogeWzN/g2uZ19kH9RWiZY+B8fXHjPXS+2CZIOG
	 J/l6sCdPk8QakkAqH/6Mi+MX5rz+yeq1sopwPy8ecXz3nsjUJxeRo6m8Ovj6Ex5J5yO9G
	 A+Gyc+bRyow5xLYSBvJMUVf4lMGNG69c8OXUGr/Lzf6usNJcYrOtiEUl5SMBKZGDWaxmZ
	 yctuub9IMNd9OBJf04m7SNvAbXVTljV5q9/QuDCIifZphFJVnhGoaR6QJ+f8drp1YNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/NgsNkp8BRnh0O7U3mVOyzwaYcfup35GvOJ2Bq4H/uY=;
	b=RRKKuD2fSs6XV+NigqqCbDyhxvOiAZu6/gNn3xo3h6pwqGp7Nx94HTes1x8d8xBcZIvR
	 BZx5XkxZPOavWqE2T1ji16Ez1vfKIy9fBftKAmEeCQzw8D44v5M00xg5RGnnh236oPwZB
	 IbNRj8olQ5JjuOvsfbdkK6cdNSxtBfHB5KsAQxdrZsYriDVK/iyXVisBzI7/uuEYpqZt2
	 6u0ER1yEsPXAg4AbXLLSObdzGsWmiGdm/XmDeaJQ13uqy+h5aPswFhaFJEGl91agH8bxs
	 hEj5FAXd6dv71W+oQtZXWx97foPMDijtTT0WH3CEtBbcB9tO2KtSMASC9aO2yCKUvhw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690030;
	bh=/NgsNkp8BRnh0O7U3mVOyzwaYcfup35GvOJ2Bq4H/uY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ia43nQblWcloyIvuho9s30323pkxv6/V/69ExILMuK3zioibRKA/K64N4tFXQ1PVe
	 OmTOQzqwFLZvk1c6bA357go2N9kC40mnyLabzN7EupQrqQOvXFfgqScYsD+PO/mIjj
	 nVxviSbZFAtjj5KF7wQWuuhar32yjoSoeYwKaXC+wdAE23HJ0dmkOObX+dOGUOAw1T
	 1NCd2KQsnI8gudwhhQ9fv8oPdrAn03Js1t/Up3kR6R1Tf+Kgco4Xp7bIG4rvKKwudt
	 a/JO+Tnhnnf9j8xoMqpq6wiKPO085lB8tmoCi3AM0OO1LS85sogmMEuOjZkXRVZLFk
	 fYQGJKji2Z2cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F4794090C;
	Thu, 26 Nov 2026 10:47:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C7B4432D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:47:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B989F81116
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0OW2gqG1W0O for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BC94810D2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=N/WUhhky
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC94810D2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39B884005B;
 Thu, 26 Nov 2026 10:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A85C1F000C4;
 Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795690019;
 bh=/NgsNkp8BRnh0O7U3mVOyzwaYcfup35GvOJ2Bq4H/uY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=N/WUhhkyw6gbI6I3HoN0FJNvk+nXXBih3PnfEXkyzZdFkExfXiiu8IlhzDbcxtSCk
 hZtr2lkyOsA198Puz1nytMrhLDKhW6WtCt3tsZo2JNceu3FWbNUO+GzxZKixvt0YfX
 3OgK5Hbdqu6jH35/s8SbVcTNGQaCSq4WbwRP0k0jnOKl994L0/eQ2vLVGozpWCOVff
 Jq6xThqMdfuhnjGiiEqPfA27UIwi7F7aLAuOlQLRXbMXApFvmE/4p3SE9kW21A8kdP
 FMdqqKvPGcaRjj+oBcdPd1eMke9XNrC5goxubTDIOd1Sg9mqWAdJBy/lrEs4GDD6TM
 0b+XVHagFukfw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fastboot: spi_flash: fix getvar partition-size of raw
 partitions
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
References: <20261117-fastboot-spi-flash-blksz-v1-1-17965dcd19e1@baylibre.com>
Date: Thu, 26 Nov 2026 11:46:50 +0100
Message-Id: <179569001020.2141121.10710008973488685666.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=395;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=IAbnURGOntohX2fhtRHi3I3VfUknMSw/4oB16H9G/YA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCA4cHX24zneuN6VnDzQm+lYw2nE/mMtM+vQWT
 Oioj7Ggna2JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgOHAAKCRAZDR20Zk4Z
 NR3DCACx9swYDK5aRSTOuJm4AZaZ6tKajeshhWyDwDp13NKAXcBClXpPXLJUJBXq9HwUTdoAdq+
 fACR2GTJ3WjNXYOa7vqUnIm8TjK4rtJHQguOI1DDxunNaN0X/eYwtjpyz6YwV1pVvoSlkVJOnyN
 2u2tB7wVZm5UxPepjgXMa55zxZgS3xy4q63CE8SeZ2z+QJcE17dISJaOhlRQYSAcj8gkfkMCxvG
 2s/So6OM2J4vhH2AzTeenRtrjmYi6fUzvaoVTRYv6KCOQ2168GaR+zW5CLW5W0qpZVCuyt2lZRF
 xdQSCAw6f4gAfzJaf5X7sBynJK0B42q8D9NZbBsWIq/8xiZ9
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 18:21:43 -0600, David Lechner <dlechner@baylibre.com> wrote:
> Set the block size of a raw SPI flash partition to one byte, the unit
> its offset and size are given in, so that getvar partition-size does not
> multiply the size by an uninitialized value.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
