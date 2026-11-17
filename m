Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179A606A32C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u9GMVgN+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6Ii5nHm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73A4080D62;
	Tue, 17 Nov 2026 15:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3FOM78PV1nJ; Tue, 17 Nov 2026 15:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BAAE080D52
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794930225;
	b=gD/3RdFzs2O5V1gM1QuJJTidLOV3jCS3Rmb7eTS/YYOSpXJczMWEU60+Zz19MVB1i0Sx
	 PxrPJV0tW/Br/zhwt2Xup7xTkKnZkVl4NyxYFUTy62vmMhYu2aUcssVqzQKKswGh1ycr5
	 ZxyFbO1kryxhebOsxlzDAXcgsuAISsNOAO0ZV94Q5GCLozbKLO6pFNCvt1r7BLHZg1GEj
	 43Enx+Q9tDq6YIbrCu33zu6nK2GZREryAiiu8Us6HbgkTr8Lo5OHOUXyGPehrDVSdngHN
	 p/rZQCp20VvFHw7i42IgUrQLEbPdatFf8qDFOUCwXRA/yVGx1nCpOTr2zTUuT3/EKCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794930225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DWaBvaLx6/OnRXR6rhYVXQ+isR/TXmRMU3VfjhDzako=;
	b=m0SrvnkVV9mGjb+RI7h0qOgIjrNjl93hU6ayUHbOfFhXuxITcnYFW3tCewnjmLER43af
	 r8z6SHd2dNT0hepyw2p8NDmG3L2shhljwq4h4UsIw+7n9ZbUiPxfK6qtKENtu335dg6q/
	 CSxNrLa0hU6WBMHcKuXvNuk7m0juPqmab9WzAHLolUkS1nEeOBF8G73emgZ+VYU5tX8oi
	 WkLQ9NxgvaT2JN0yQq1ZCAC4Hj9pMkXhRvd0W+5MxiPmcplaADmO/RSNwOjs1eQpCY/On
	 SwBM7IJC/ZOnu2/N8KSZbzLoVwDgCwOLjLZ2TbCI88S6EJrWV9mt/fdtZ2C56xFIdHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794930225;
	bh=DWaBvaLx6/OnRXR6rhYVXQ+isR/TXmRMU3VfjhDzako=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u9GMVgN+YL8tHHBZ1ztbXZ+oOeG6Tnsgi1uvuM7OIQra2uXgg+EW8lvWMisl0IbQ6
	 rnWdX9QmKsxGeosvPQjMh/CW0xvACRjup1tGxBttTFudNPnC5gjmc/pKN9PcRoTUiL
	 aTIxNEw6aD23eUQkJyZl8KnBQlSQmyg7T+bjzCjJgnWQJGuPHq45TcoSkwWSUfIwFn
	 Xpv0bSyUPDOHh9FrjgVLEp/3jyPcjH0nOYUDlsIKM+wmjTuzHjaSUhik5yUrZYWo3n
	 ge17r6GAGovlusSAeEaE+XDVQxq/2uz/AzVkuA8YnEivMyR057ACY2oUtsGcx+44SF
	 GsEUaMKqbKXjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAAE080D52;
	Tue, 17 Nov 2026 15:43:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B8E105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA846408D4
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kxrnuWhM3KlP for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:43:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CC5E405D6
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k6Ii5nHm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CC5E405D6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:43:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37D4060D21;
 Tue, 17 Nov 2026 15:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0991F000C4;
 Tue, 17 Nov 2026 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794930219;
 bh=DWaBvaLx6/OnRXR6rhYVXQ+isR/TXmRMU3VfjhDzako=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=k6Ii5nHm/DNEu80sIoiqol7fUr1rG1opQIaI6l8zAklCGjrpEN7vM/eLbaQ4h2gXT
 d49R0+1VMsj8oUabXlR6URcSsQRwQpZgn8GhIcpMDRveCq1wJpq7/FdjosSx0YtbyE
 k0em91PtlOl9mQD0OMsiCSFilYJQx7CllwqH74CIO85CXMJDsvQsLkYdJFUatHmqjT
 woj5rBQ6ZkcYqfGUi8tozsmF9UBw0m/z79aroK6E0WMKJfOCw7DGGFwQXxwowVYyrX
 LhF7nh6PyxP2zuPavwOfJqdnEuB8umbeo6gF8448YP5a8koeMusBI+YMbl6xBWzTL0
 g6Q+ooZ2gNOLw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lukasz Majewski <lukma@nabladev.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] usb: Constify driver ops
In-Reply-To: <20261116174446.3488393-1-marek.vasut+renesas@mailbox.org>
References: <20261116174446.3488393-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 17 Nov 2026 16:43:37 +0100
Message-ID: <xhkdb4idfqx92.fsf@mkorpers-koolstof.csb>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

Thank you for the patch.

On Mon, Nov 16, 2026 at 18:44, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

