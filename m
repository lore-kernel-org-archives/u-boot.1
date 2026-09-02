Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12716C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E776608AF;
	Wed,  2 Sep 2026 13:04:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQ5o9GhFK7Ar; Wed,  2 Sep 2026 13:04:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788354242;
	bh=UmoEWU92E1HpLjwJ2sA5fVwSWiWOgEqHKodqTZVG2eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/kibznkiYL0x0IAd3+LOGqDPdlWSHwQXrycGZsnuvO0vVsy0+03H2XO2DjfbO7q8
	 JuSNjQldEF2fMn2KjW6EX2dx8bmUR1M0JrX0lEBa7JJY5fVE6tSql5WvP0TwR9LyAw
	 eTLLPDF9PGQ120j4jLQeWpFvEXDDv6pPgBkdxjeKEsfS4VegNEnw3CHt4Li0l2wWF3
	 Cu/HIN5R3Kul7OVNAtyX7zndzA4PBuvsb8tnBezVpMoZynTte9vBRW6bzryx5AFLHi
	 si2o5p8jUvd/T+x4O87wIk1JzEamKABW3xgHmxJCXi296ip/NkE7dZmtxnkQnlWaR9
	 +OR24fcwV+aEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8207460726;
	Wed,  2 Sep 2026 13:04:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 61599127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 537D640660
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gk8brenBG4G for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:04:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Lnd3ijgU
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 974EC40637
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A3EB600C8;
 Wed,  2 Sep 2026 13:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C071F000E9;
 Wed,  2 Sep 2026 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788354238;
 bh=UmoEWU92E1HpLjwJ2sA5fVwSWiWOgEqHKodqTZVG2eM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Lnd3ijgUf3t1JODCC7DHSE+3GocDJM0RWlIpkkEtlbdcTAqQ39LuobC5j9qCwfnzD
 vNWyB4cTDrkeSU4h40jjbe/BEu6oahXaSs+0QNHNbjSp0ksFk9RQVC5eQv2cWXGVsh
 cPDcsZi9BMd6naUEfuSWnfTyqnnDVsxstSPGrCBQ5/sj/+C9CXTOS03aHgBm4UA7mj
 5Ig3vL5iGa+5OVYBvpC8QKrXrOQSk4IYbzgkyWOSlw+kwdidMbYea1cXQe5lKTRhLV
 6iI0bgR7MZysKOvsEp/GLk4b9x0ShGommuc3qpjC1oVtWf7Gl7CGA98tLGpObaGZ0J
 WiktvQcnJzqMw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 3/3] avb_verify: read_persistent_value: honour contract
 regarding too small buffer
In-Reply-To: <20260828105005.200338-4-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
 <20260828105005.200338-4-ravi@prevas.dk>
Date: Wed, 02 Sep 2026 15:03:56 +0200
Message-ID: <877bl3n6tf.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Rasmus,

Thank you for the patch.

On Fri, Aug 28, 2026 at 12:50, Rasmus Villemoes <ravi@prevas.dk> wrote:

> The avb_ops.h header file, which has been imported from the upstream
> libavb, says:
>
>    /* Reads a persistent value corresponding to the given |name|. The value is
>     * returned in |out_buffer| which must point to |buffer_size| bytes. On
>     * success |out_num_bytes_read| contains the number of bytes read into
>     * |out_buffer|. If AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE is returned,
>     * |out_num_bytes_read| contains the number of bytes that would have been read
>     * which can be used to allocate a buffer.
>
> The invoke_func() wrapper does translate a TEE_ERROR_STORAGE_NO_SPACE
> return to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE. However, this
> implementation of the read_persistent_value method currently never
> updates *out_num_bytes_read in case of an error.
>
> Also note that currently, at least the upstream optee-os
> implementation of TA_AVB_CMD_READ_PERSIST_VALUE never returns
> TEE_ERROR_STORAGE_NO_SPACE, but instead silently returns a truncated
> value, with no way for the caller to know that happened. A fix has
> been proposed (https://github.com/OP-TEE/optee_os/pull/7959).
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Ilias, this series touches both AVB and TEE. Can you pick up all 3
patches or do you want me to do so?

If you wish that I pick them up, please ack them first.

Thanks
Mattijs

