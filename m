Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDA606A326
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sbTtQ3ia;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lATmQcHL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4881C607ED;
	Tue, 20 Oct 2026 11:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9j-iKbRHGLb6; Tue, 20 Oct 2026 11:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0273607E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792496364;
	b=Dhbz0S3g5ghuBHgJnGeyVY3NSzJdt/h71R7iBUAGbPiOzfX92mit9rb2ER5UHrubZ3YR
	 +zKv0+3Y1RKB7050wFVBJp8cc7EOghysjG0WTpi6VUsFQaT+cMgCBYSGE9N+TVJkBbux1
	 5JlIZVHfdOTl2mMawB0SI6l5mlug0NLQ+suo2rTJjulsOUU4bT/l9hkpJghguqR397LAC
	 xWIw8CmyO2KXNCnKvZFu5M/qUc/byUgsEQUimYlqMBsqFmY7Lht3CNKMOyLlz5FgqXcVw
	 /vUOLsgiMkyu6loWjoeZPODiuaaZmdCBsdLlLfB/c5tMvmhGfDq1pgLciZCGu9hPWRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792496364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yIEXjezyLMRxnt6UKeHyCNo7BPxVlQsVfaZBXqfiVww=;
	b=JRy8lCOY3EPORGTmsZpeShxlxqUphHoEQGX0VGmtlGQqUaPv9xUy4eaqdlSyLkRxpuJb
	 tmvnjyrQGPEj1s0YMScQgiDp4VVXgAftx7nzXNbqXJZsFLR8Kd/ozhVMcIi/tVfNyHh+o
	 ylcYsA+6wbWrIAz9epBYhk9Fh9/1MJBtPOyAgmhW2iGRHKvXgq9BhmC+H5wLh2Kz6+C33
	 s4HE+d5ep7FCLfKutWk+huPY962eL7aYN13/f7mTcUbmD8WkDMPZtBXGDbxHCH9LeYFCG
	 WFfxfbUcoEOd8+8a5Advezrwaz8E014nlIWCwndmqmMGKrrZmGOXyQa8od7eGAkkUdw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792496364;
	bh=yIEXjezyLMRxnt6UKeHyCNo7BPxVlQsVfaZBXqfiVww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sbTtQ3iahl35ypwf3nAJoI4M91r3iCIr0WY5mOQ0Qjl6R8bbsMxr+MZCNB8iNa4Oo
	 tJCS+w0Kv3Gq9JSbWayr5NZZkzpLoSlug7pwpX+i5TVvxUJ10rqabFRjtQPVZ8wiKu
	 HypFQKUJt605Qm8vpi7c4ehMyBAlVkMuzuI5QioNo1h/VKmuVJsg1MU7rAgnb5RjK1
	 sdJ5Ajk1DwM3mgsFqORDKWXGE1TBnc4uoH2eU0gqGTSWEk4KqsxsWUIVaF7QxV1JEV
	 pPOrlybJLL5eiWiMHygyQEqgTQ9MwNA7PB/OtykfVq/5BGTWCWPc6TH803wDWblxm0
	 vjOI+CgN+TIUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0273607E2;
	Tue, 20 Oct 2026 11:39:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85E3823A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77B6C40583
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YZDJ7WCkGHLw for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 11:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B43A840537
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792496362;
 b=ZoEG2d7rFEzDBz3UJCnNc42DKCOP07spBmGgLy5sg+pP6aW2nDyBjaErFKVQm/Due8q/
 CIZv6KbfRMVgXRv+sYgBaNSwNDeJoy6HhBWjxmZd4fceosyhU7KQ9bBhD5sfbgbnOXB2q
 /oboAQxSq133A+R6q23A4vnlQFrBRRAfO7g6z0fOzydyZ+9gggr8Lkjf2BTup0WK5Xk26
 ffEls9soTD/vrvDz/uvW9K1zzO2eoiwmhyT3MDAKDyPsi//Cu3RzuqNoOkHMpu2GLa6Uh
 SQ+pAbHnTx8HYwJv2vknMcUAMDPojCtA6CjttnLrNVGhnmXakLYaYIQRzVQLWV8KMTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792496362;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=yIEXjezyLMRxnt6UKeHyCNo7BPxVlQsVfaZBXqfiVww=;
 b=mqRe22R92S7QfP5m3zdwMR4NWv1iakD3YGVLoUaD7fpHhIEfEXtrbg6VWtWFxjCABcga
 osRaTPqW2Nqlq3cc8Cu/sH5tAoJXZe8A2OhB+PosNwmJp8/sj+Y0+LNE8eooejq7WZw8v
 Y6NAzpHcD9Hg4qpxs9dTEkJRHwnjK579Wk5B0g5vr6j9OEG5JPVJw73rLuDSDMTXH9QtJ
 AI2xnDCsGaF53oBrLZkVKhtOnbo8dkPoTwTYCBc6SyMknijFL/wZfHTaI15eP/KNF88Wy
 OLyAjkfC62jShO5zYb3wIPydZnZD/BVY34Bof1SDYCxY5lG5SDoWAKwvddL0QyzeBgA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lATmQcHL; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lATmQcHL
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B43A840537
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:39:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43CFF60534;
 Tue, 20 Oct 2026 11:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C11F000C5;
 Tue, 20 Oct 2026 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792496360;
 bh=yIEXjezyLMRxnt6UKeHyCNo7BPxVlQsVfaZBXqfiVww=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lATmQcHLLAroP60ek2zUp9c1AIn7NcdWlLd58tA2spII+tyDbLwjC4yMipDlluSM5
 jDzyUlpZoVLAZw4eSFCcIt2yE9s3UZ5wQWdc7BDKXMMJh8wUS7n1uwoEXR/9e/0vhv
 0649R7ENU3A46QJTrzlamgGkl1sYb+7nVMO0C+o5Jj4r/AhWW3eohOkwrPdvK18Kba
 JSRNwLjYjQ6PRdIWfAPPzXv5XZN/GZOXVnTpIzgw0eg+1nBZRCnd+EWnSIy1vaPceo
 lpxaTFxDYCIrKnVGlnBwYTq3qOZm9gzmDuNKNFRdjNVHWRL7D4CY1jdW5HjIp1a/BG
 /1h0nlqi9KqsQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: Re: [PATCH v3 2/3] blk: Add a name-to-interface-type lookup
In-Reply-To: <20261016072640.772964-3-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-3-jan.kehren@emteria.com>
Date: Tue, 20 Oct 2026 13:39:17 +0200
Message-ID: <xhkdbbj8o4n4q.fsf@mkorpers-koolstof.csb>
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jan,

Thank you for the patch.

On Fri, Oct 16, 2026 at 09:26, Jan Kehren <jan.kehren@emteria.com> wrote:

> blk_get_uclass_name() turns an interface type into a name, but there is no
> public way to go the other way. The driver model block layer already has
> the lookup, as a static helper behind blk_get_devnum_by_uclass_idname(),
> which resolves a device at the same time.
>
> A caller that wants to accept an interface name from the user, and only
> resolve a device later, has no way to tell a bad name from a device that
> is not there yet. Export the lookup under a name that mirrors its
> counterpart, and add the legacy block layer equivalent.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

