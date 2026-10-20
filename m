Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA7606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WP3DnhO7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CDoJnH0Z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DB43605FC;
	Tue, 20 Oct 2026 07:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mIFl0Bs4d_hq; Tue, 20 Oct 2026 07:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0116607DD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482822;
	b=BiWGc8K87G7fHeAv7XzP80r7WxNJ+6+ztNQEsHHMyYQnjTDtu9XNAJzxyni0QXYIwlTV
	 B1UL3Lag3+esVYsrWUga9qur7tYh/fUugwNFaQFrLHBP3EpjiRIg5huef4Tm27b+z9n5a
	 I7m56fDXYRmk/si7aWMPoEBIqJFNx+Fck36tNyfE/dnpJNr7SZ+ZLWa6hvGi3nYqW1aAz
	 LGxXRkNjRnPZfo7hMWzwqky+8oO6D3t25ZF4BEJWebxu9xeT0Ko4RAGxshV6WRVlv/mqX
	 B6GnMesTGeeFBbvs0f9SJGGIwIw6U54dqcppVTDsaBlrPpFjDNjQh6KnthqtwqKIFUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y+eeKBkO0nEfvFXepGwHJ44okQHwTWAOj2NLbAI2Ers=;
	b=FTPaURiOGy+Uz5hAqfd3LYgnNU+Ep7mzBFX2FjWlfWzpxZMKuTWvTN6JUeEKJcxUoyWS
	 +UF2gBiCKEicfCiSn7fyYRKZPzS7hkMJUJXrHqvMnt81BcVW/vM6ZEb1zeoIt0oKEFkla
	 eCjzKKYf/ZJ84np+p2CKdvDr1gVdXzPdjSC+JAwDhRaPYEDGt+eTAHggjrNruzqSxwLIA
	 rHW1Yvp+NPYl+jhwt545KVBU7mjp9U5VwA89oBP4AvhApscMet/UUb1A/gOZSjEzsqrZ2
	 u/DrLMsER7MRULlGlC9YRg65tDI1XwKPzuP6TVil7i8bRVdqCm+M/KQuen9w1B339Lg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482822;
	bh=y+eeKBkO0nEfvFXepGwHJ44okQHwTWAOj2NLbAI2Ers=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WP3DnhO7LoI28LDKfe8E6aO/6t555vCoA/Mi/ojw3K3ix/HqfYbPl2N5uNXbB4bDk
	 SSaiIg2FhHzeqOAXGcRm9ML0R3gt6jTz31XZft9iGIpCe23cljlwEloF2WXPVhPDNz
	 SKW6ojI/mLREs+tgJqWhytFnb4/ZRFjBFh/obqzz/tRdZBxWZo0GBit4NbiqdRiddI
	 LuPeCfgLRb+NJRVeKLjdFg9QI6kA1UpDmbwPuaqTFi+GOJbnajuDF1rWzaIfMZ3IEf
	 8CfV3q/WcSPyrr7WrB+AfHV39kdzTQvAZO7AGN1MWhe2PdoKcmlKoQAb4VWHtEx8dZ
	 W0AdMzw2Fy5yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0116607DD;
	Tue, 20 Oct 2026 07:53:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE71C23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCE2B40776
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQvxtVY0Ezsk for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 026F840743
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792482820;
 b=CL3cSCp59nZHRf9R68HJRDKROqTXMkapyRuGUpysP8zElLLeM3UFK/PwgfZvOUCzzTe7
 XpOroL7BAUS3W0lPO8lQHNyCahjJ2MAL1NtVAtnug3M4w7NPpdFiS87thgzJFWKdKFl7/
 r2m+zTDxm9jqbBWGpUsmPBUB4P+mn0Zs3g4FrZOjC9UsUaIQ9Vup3Y76+/abIKInRhR/h
 WSDDywNSjtXecyRyfnjIsiqZkJe4jxyXLBQ/GuubSqcph5+1v9paKZwrANQqvREbgTpef
 hVJvwfXd78/u/7RbmSVA6l7ex2SemswCXr+WOGmikLzJ4FBk0iI2imJFOV7ZPOh6aHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482820;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=y+eeKBkO0nEfvFXepGwHJ44okQHwTWAOj2NLbAI2Ers=;
 b=kWSHc6YSv4LayuHsduWHKuMktdCJcCLUt3fgz9M1RV9ERZNf2J1TGAx2s4nvHnBPXQV9
 cFy1VECdr8dqs4advTcEwUcCQKR0JW+mz6ipNg784GwxeCSKR1XXHMPYO1hDes/CbObqZ
 C42I4e9SsU24S3FlhF+/ZCfWt5y7Eg1Afup9LoG1vcvtXg2v43Z2dBqtX5kU1CnmJncaC
 /NU4Yw3gFTBcICybaRaAcFK57SaEPDtT1t5e40/x5xbuau7CZcCl8Pjox1/qiHS81PNJJ
 UaBu0lwkiiQGhN5/53ePUxI7eI9X001HbBNj9dNHKHRV3jjGKe1uUjASpq0u5Sa6edA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CDoJnH0Z; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CDoJnH0Z
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 026F840743
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:53:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA019601F9;
 Tue, 20 Oct 2026 07:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3081F000C4;
 Tue, 20 Oct 2026 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792482817;
 bh=y+eeKBkO0nEfvFXepGwHJ44okQHwTWAOj2NLbAI2Ers=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=CDoJnH0ZK+9U+DBzbbACaxYkVXxdoSSncd/3852ZJk+IL98gXG8fbEGFIAXM5jUIB
 61Vv7lnpgumEOheQnSH/N69K3M0nMXbOTjvnFWfvy1DopZ6Hm8yyu5TSzjCZGkUAFv
 oCtEYD0pXLV1b1xGV5BAXHj1NU+Atb0UXzlj5NzeT6o6j+pa79WUUSpA4x08Gkluc5
 afcAr7O5ItHM2SZV0K9MbPwHjEPWDxXZaJ9vGo1Pl6DJQDHlLgGY45prGxGxpuXOf3
 G8h3d8Vwg82GGCrJe9v7vT7jxBUft/PFl8fBvrx7NXQO51dLCc4I9OY2D4fC6pZwgM
 PRpozeH2DWLfg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/5] avb: verify the boot images in the buffers they
 are booted from
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-3-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-3-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:53:35 +0200
Message-ID: <xhkdby0bs4xkw.fsf@mkorpers-koolstof.csb>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

On Mon, Oct 12, 2026 at 22:25, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> bootmeth_android let libavb read boot and vendor_boot into its own buffers,
> hash them and free them, and then read both partitions again to boot them.
> The bytes that were verified and the bytes that were booted were therefore
> two separate reads of the storage device, which an attacker able to
> interpose the device can tell apart (reported on the list as a TOCTOU
> issue). It also read every image twice.
>
> Load boot and vendor_boot first and hand the buffers to libavb through
> AvbOps.get_preloaded_partition(), so the hashes are computed over the
> memory that bootm consumes afterwards. If a hash descriptor covers more
> bytes than the boot image header announced, the tail is read into the same
> buffer, bounded by the partition size; a descriptor larger than the buffer
> fails verification.
>
> Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")

> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
