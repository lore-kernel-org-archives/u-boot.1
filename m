Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1A606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f6cTFgcd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ACn0sGdo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 263B46083A;
	Tue, 20 Oct 2026 08:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gvf0MYr3NK00; Tue, 20 Oct 2026 08:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 82580607FB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792484875;
	b=V3g2WckjesYP9nNKH5EdG8fkkhC8xv9cdzAb6i980CYt+dmWqAOEnH4AFb4to1bd9Dyd
	 geKGvRkjIktF77Fg+lo6aZelU6MoX3aNQsD+VzBqpS9OEspH2ZjWAF4AhNbv+wRvGTaMW
	 moVCX5YHpkkTMe8W8vNoOzVBx/yQNvkVVGjyfAqmR0iwSp9sgjdW+f+/lNIecu6EYJvV/
	 QfCvbTN7Fv4AaLv2Iou7/kFYSwL39nUfvxBUSk2lgrGCQG3duT5mHj2FUfnih3Epf/Vpz
	 r2TcCcA1vmZvvcDHqT2BeDQvYtnw//QSKWaI2Qifm6mVSpe38Z/soc8j82dgbYoiA7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792484875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vs5srvfebbA4iFdpgm/69weX4HaF6+3KQzfdPz9fvAk=;
	b=gAFcFU87OnKU7vGCkVzzAQoKzjnjSvOjsbjZhQBae1SR1U6NcmHvzkNpnuB2JzWdMJe0
	 1o81N35Ldu0/4FgHPFQ7gx64GKL1Njnsl+W27hH2murjufo2viITVTiqWBW2H1Ot1xXAd
	 ACGAh3WIn2K52aOlXyIz7jbD2pZzh06/nEwrNSSByAjSmCNlC5DYvql2x/TLAeYuONlB1
	 kNJ2mqaoleQzKDySZKZEtuwJqbkZ3b5kTqcFeukiIieBdX4eo6Ppx5S3BtzcZ4uw1DDcs
	 ueaEu9SIyAQt/ejchFbM4JhpZDW2wgh08DE6dsgxXp9xtOT6DNZ18oXhbvba61gb3yQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792484875;
	bh=vs5srvfebbA4iFdpgm/69weX4HaF6+3KQzfdPz9fvAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6cTFgcdVnj+8+sRHrDisuGvWQGgqfrIC1tEzjwY9cmzK1CBGZm1x3wHApMLTFy5/
	 qhFpQGxtCUxIwEa+s1Xpv57Xxj5dKDWEeQiBZvWSAG4o/QBiOnIH0085OS+Jh1ktvi
	 s3sNFk2P0hwBZ2hI8tDQEplsw62TuCgQuMdXFimQ2toD3AxVMw6N1Dcld/qxSoHYGh
	 37FS4nvbCKKcGTqhIcQCQbgZk19ehK/zFmEF0LRpwQrS4WvB3+9NvGaoTjbbTELIrb
	 +CBPmfPiWc2Xpjw73GGANP9570+rRvJpk7+r56IYIFjL3+8Fo797W8E0rQesNCMbog
	 WWcWrT5lYjy9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82580607FB;
	Tue, 20 Oct 2026 08:27:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7C4A23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 91380407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZ11EcXIOVlH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:27:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 039F9407F6
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792484874;
 b=fD7otdQS5+LWRsmtAIar83kWiUXQ8LQxMSo+Yzn9hWr/+Ip6O8RxW9R+GErmr+CGy7RQ
 psrQND2dZlCWXKZtBqCys82TmwdcFwCofE/dXpXm21mkSx1K4Z7HlDopC6M4Tb7Yr/a52
 Iwl4/KCoYhz7mALmIlHjPss8zMHcF5xzgv2luSms9vNVkwSu2gdWeypX9dQHebsE8cZzx
 5J3nd9a+ebF3xXrgYm/Xy0QcKSNrCxXX4RcVLaN5i9/ymmyJEXvu5zptTcoJcIBLFdcTn
 M6U8WiuKfOuv8A0qp4YEvVrARVXoxs8rBVEeRvFkTfTa70cb2Q4sZICubJgLJ0adQ+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792484874;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=vs5srvfebbA4iFdpgm/69weX4HaF6+3KQzfdPz9fvAk=;
 b=R56IkdERt0akeYTg1FtTR7UnJ17mDxprKpT9JLEGNl3ZmgUakw76N6ftS/08LdveG3S7
 rJo19KFiehlNTq96D356FG/5SPQHL7cSw9ULyaNoL8a8t4R3rFmHY9EyCTQ6KVTfxBhWg
 BBJl2zP2LhUhjR5gk71q8DVmcbrGdFputt+jC39RHaap5m3kS5XIQd/c2xsFLmAthNf8y
 vWZfellL95bYX0u/Oy9dtdGSgazk4FyaR3x+bffIIJ9HSnZPLrZEVjS+MJ2Ii2ecfPsAQ
 uwpBw8yvkOPCFQB4zLUCP+jswsYmF7VyU3yO5BkxNOCpzHUxuG633D92h/rRkL6OrwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ACn0sGdo; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ACn0sGdo
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 039F9407F6
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:27:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2143940F30;
 Tue, 20 Oct 2026 08:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F9C1F000C4;
 Tue, 20 Oct 2026 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792484872;
 bh=vs5srvfebbA4iFdpgm/69weX4HaF6+3KQzfdPz9fvAk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ACn0sGdoW4M9RSBy3T5YfBmiHJcgVBUZJOMHjRnRMTZHpBT5DsScSFfMgQlcxAlNZ
 r4/RHdNj6pLYhBZX+DztJ/pjs3yc10FjBJkStYsYP/P2/CWDqdEealW5wm3+euC4KI
 VndW3bVVlvenBTQJdRcV1pLsldrgO7XCrId0yVzNmniUxQ7a9LrADxdNIbpHjdDPnx
 WQqsCPKO4S15beJzuP2nN9+lDDozawL1YtqWiNgM0/fxZzXcl3HD9+d2bT5Jfu4rnt
 NtPOCQ8Sn6ryTrqZpH31+s1N0bj7sdVvFPhgHrCra4YFeSksKc2B4mp/szZRNjry4/
 9N5S6jUt6UTdQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Shahriyar
 Jalayeri <shahriyar@byteray.co.uk>, Quentin Schulz
 <quentin.schulz@cherry.de>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Ahmad Fatoum
 <a.fatoum@pengutronix.de>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/5] doc: android/avb2: document the root key
 provisioning and lock state
In-Reply-To: <20261012-upstream-avb_lock_unlock_b4-v2-5-87460a24e559@oss.qualcomm.com>
References: <20261012-upstream-avb_lock_unlock_b4-v2-0-87460a24e559@oss.qualcomm.com>
 <20261012-upstream-avb_lock_unlock_b4-v2-5-87460a24e559@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 10:27:49 +0200
Message-ID: <xhkdbse204vzu.fsf@mkorpers-koolstof.csb>
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

> Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
> how to derive the SHA-256 digest of the vbmeta signing key with avbtool
> and provision it into the TEE persistent value with "avb write_pvalue_hex",
> the fail-closed behaviour when it is missing, and the device lock state as
> seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
> mandatory userdata erase).
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

