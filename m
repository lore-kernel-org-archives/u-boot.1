Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D96606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a3jUpkiz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQSK+l/M
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5CD5811CB;
	Tue, 17 Nov 2026 15:17:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXAeb0zfNPku; Tue, 17 Nov 2026 15:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 06A72811B5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794928634;
	b=UMz0UyIq4nuRz9bMqEwSlBE4RQ0fpJDPufd6O3Pe2O5D7+20qMjkB2W0zk6L/s7q+0M1
	 EibpPXpi6i6Fkq7fZ9cG3LeiyrAI12bbNX90NWUA2+3qPsjPsLgrHBp1VwNH9glgv2De0
	 22OcnO5npOX2H26fMwxcU3hUkWPdqjEFpa6R2Fy1Vm5tuTDZ5z8FJV86veChrRF3vdF4C
	 ULAe9EKCTP6RmMfCF3AIYwtESHQ1dQf5AjJV3nZTFJuhtr2T05JtXz0q16YHOyK0CN47F
	 qYmmkrEkArDQS6di5Ev+iwTHRxy6XYvdo2mrqyVPb4uUFw95z/QrkZsv+UC3tCrgwYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794928634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hfF/g10sVuJiOcerBC44PAuxDY2LgidL7HOPUUhAhhY=;
	b=tcCfKzdSP0jT/M5zVPqGqk+ddFw7fUE04N11jDW3EIi4pgRJGRfaHO9bWIMqmfRj9k9U
	 G1Sn5ADRA1+phAf0KQHA4ndpFxV3LIFHTyF4XN3Bk1MIU7Z3TMu8ae2uh8QGK8unouk8A
	 5P9rsOiJye78qGAsJcnHl/lqLXn/1fRGl30bB53udGgKnq1at+kfsrrzZEdm20vpQQZxy
	 2qzNXqcItGmf0Gfnq6mB/fnaMx3bKXK1SQ+rtUmL/iyW1M+WBXu1uGPjvfGMlu+vG2EX4
	 WwLWdkRb+k5YuwIHcKlW3uyYlStSTg2Qx6zGAKx4hR1g+SrBheGNVTFIZMmC/EfHFWQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794928634;
	bh=hfF/g10sVuJiOcerBC44PAuxDY2LgidL7HOPUUhAhhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3jUpkiznHaIe0oFtEXQth0tSEickGrrsXrtEOWieVCtE+v+6Oqn4lNcV3f7wXbEA
	 ixTE2d5QVafhyoRDET1hCVQc7yJiObLUu4ZpHg4bSDa9A3Ka5tVYTG/UoNFLWDFw0Q
	 OZGAEKey9NAHBmwUMuMVilKoPt/lSM58qc1il1vF3d7C7xH5sDJTbWbRP5/jzqrYhM
	 okL/yJQ02KE8XQzR5FzYJQcegl7oz9W5KNZ0jTRiA2wtytWrbUjY4nPprqjCScaJjw
	 duau1llUipeXFdfHbVgesM13OOlqP8o6TV03VkzqIsHgGbeBQ3/vdqAgVKnQ1gQixw
	 jkh0cG9JYwOfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06A72811B5;
	Tue, 17 Nov 2026 15:17:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D69A21A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C80B0408B7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdGCHlNJ8MSJ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:17:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BBC94083E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=JQSK+l/M
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BBC94083E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:17:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FB98410A5;
 Tue, 17 Nov 2026 15:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33361F000C4;
 Tue, 17 Nov 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794928631;
 bh=hfF/g10sVuJiOcerBC44PAuxDY2LgidL7HOPUUhAhhY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=JQSK+l/MxHWJnl9Wnf/YftstwItw5fkb2oH8lz+cukx9Pdt4TBovrnh2ZDB67liOK
 p+Xe0RSiw56MxDGtLvFO5X6gat5U1u9xDQu+wIPz6LyJbYtGmAuVMo7L2WPkhaHlbU
 MU8PXKLhVhquG0yvOWctFjExsaI5b10+lzN5Fssx31sCdJTQ/qXsMR+9dAsW1uKY2t
 p846X6kNIIzyWNus4O5qgm8MQ67XIWhv8NCvjgzC7wmpnS5vhRMzpjRN2DGeM6Cwnd
 r1PG7dPhVgBl+TFKk7rxYbcobA3zFVtZti+zgZbh+zN3D/5S49WR8n31sI0XWPTCOT
 7H3BSjiDMjUQA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org, Jerome Forissier
 <jerome.forissier@arm.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, James Hilliard <james.hilliard1@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 3/3] common: update: Port DFU TFTP to LwIP
In-Reply-To: <20261109032700.2839970-3-marek.vasut+renesas@mailbox.org>
References: <20261109032700.2839970-1-marek.vasut+renesas@mailbox.org>
 <20261109032700.2839970-3-marek.vasut+renesas@mailbox.org>
Date: Tue, 17 Nov 2026 16:17:09 +0100
Message-ID: <xhkdb7bibqyh6.fsf@mkorpers-koolstof.csb>
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

On Mon, Nov 09, 2026 at 04:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Make DFU TFTP compatible with LwIP by implementing a slightly different
> and simpler TFTP loading using do_tftpb_raw(). The loader supports all
> the functionality that was supported by legacy network stack, but has
> to implement CONFIG_UPDATE_TFTP_CNT_MAX manually.
>
> Tested on Renesas R-Car H3 Salvator-X(S) board using both:
> => env set updatefile update.itb ; env set loadaddr 0x50000000 ; dfu tftp
> => tftp 0x50000000 update.itb && dfu tftp 0x50000000
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Jerome, since this is series is network related, will you pick it up?

