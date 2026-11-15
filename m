Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B505606A329
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WkDcKMB1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R5EreU1C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4042D40732;
	Sun, 15 Nov 2026 04:25:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iieAFG6o8UFy; Sun, 15 Nov 2026 04:25:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83EB040733
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794716720;
	b=pKyOlBtWOyOibJyBgM6K/aA/FBudt3xoG2/O09+o9we16UewIJNdpucuV8YtWU6VI8wq
	 xAibULkX2XzBTSmK0FJ1IG4mKjvECRpQONdM9ATw5j9deu5xl/087y0GvLGWC25G6ZXVK
	 qXA2oN7e/WWtNb5ppuo5KaXdEDbvp2bJsWoE4jyFFQSexJ0V8mT4S7Ej6Rypw8CJp1HAZ
	 dMXFrl6ml0LB+D0W3HQBn0BBvDe+naiyPrTFsM6/tCJN3J3yt1eJGkBLlUipmY0lcugnA
	 lmvQV1nlz9Zs8nMeP6Ei8awatDMea1w4BYUQGKsDeZ/F+renpgy8ULOGyu7gWYkSlfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794716720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bLCwER8Az611kz4FevJv0Dyw25aXiWcTkgYHY0UcE+k=;
	b=WUZNtPt//pPV1aHL0SWWDbqazGzSRAHw8iVjXJo9oqLqE1R8RZSqvtuYllq/uWjS5Fug
	 OW5ESQaSTCnbtXwK+XOyLHTB7IjpdGekVK+AdvyRnSDFyrdNxkEGNdJwYMLpkfKEZp/5V
	 26qWSjBZ43oLm6LsThKWYi7wTXHIC+0Xr3GoIg99kTyiATv/V3yHyN6fdUQuBkB7TsZY1
	 7oC/XTEXMAgjT+DUkOThz5Io2NkRwFcQtjmo+qb86ie8FOzAHBgDE2+uYbYc4KEeAcdcf
	 eMfLExBvCIrPsEWYp0p7y2NdG0UmH2bOQUcncPKDhTs43IRmrmdZMs2jka0wHlwnvsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794716720;
	bh=bLCwER8Az611kz4FevJv0Dyw25aXiWcTkgYHY0UcE+k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WkDcKMB1vVxSlcj6zQGIJI8eF4zrPABi88fLd3nogDNv8pnMlk6891T1wQTg8Xr8S
	 NRTmnXiYP0MCclw9xaRYA+3ClkpDabx/otIjLBgBgaXbHqSYsd/b6E/IyNeJApWIwT
	 7OUknyrAYEDVxWCusMevyTlXp53ze6c8qhhEsfsTya2AOZj7geIgCwB0U+wr77tNYN
	 rxyPZebOVEa8MZdgmKYhNWupHVsJFXW8MmDM5kF65Pznf8jq83MJh/cpb/078LSs/Y
	 OuVBRRPtOYMxPg3ZOr9lliT6jK3GFqSheHmXYrvh+od9gj8fD7CHo6gar/YfV8B+80
	 bnJwQF2q520zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83EB040733;
	Sun, 15 Nov 2026 04:25:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E7270B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FC8F810D1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIpCX56bizmA for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 04:25:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F204810CF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com;
 envelope-from=atul.akella@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=R5EreU1C
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F204810CF
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 04:25:18 +0000 (UTC)
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-170135e43c7so3570522c88.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 20:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794716717; x=1795321517;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bLCwER8Az611kz4FevJv0Dyw25aXiWcTkgYHY0UcE+k=;
 b=R5EreU1CsGYmK9tlEOqZe+v8vFw2SNHg32VZVsUuhArEC38ZJ9wPPgNIxwQ8RHsAjT
 85pHi3ugLWL4rOYqRMzp6hFNIfuOzFSeV75IfX8g09wogs5dsyNyvRf/z/OPGcg7JUA6
 +NiA/hOkNK+uU0pgS6mK88ujoyBFkDIUnm2YbVHLUVRGOggUFtZTdu9IIhNisx6K3EGA
 oHSd7hVGvkfJlfEQ3O5FNx9kBEYEk70j+HGyUbJ7eGUMZlrnManAX/8EMFcogC9CRPT4
 n84YPVSckdEtCivQ0xJvpoQtRb+p5BCG9uolrj59y8SN9t+z1PB3Tbcy4rdbOiouDuhj
 D1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794716717; x=1795321517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bLCwER8Az611kz4FevJv0Dyw25aXiWcTkgYHY0UcE+k=;
 b=hHBxSaiiQq6mQx8jSakYuHaVkkns05ohvxjnepbyKPlv4QVj5KbZuPGiBX5anJsjGZ
 1iQ9LOhORXhvmyRHTs4lb6km8oi89gTJ0z4z5uNVcNTsc9muRb86K9uomfMJuZVlLHvK
 1yW3QvjlRjiJBecO8RMGP1J5aj+PWz/0QynCWoMTm0FxUhJUn5Qaa+BjkLZx33ifY26T
 CAtV9ufVE2SyufNxIS2lyypPEIYPCz30Ac8vHBdZq3RajOOHhEZc0iYUAKY0U9thHN0N
 t1UO/aP9o/I6BN2YiQNfhum6xy0tsj/3ZufzTLSqVCciV+8KyZSbjRbVMlW05IEb/55c
 Pryw==
X-Forwarded-Encrypted: i=1;
 AL+hErGKYoPjL902gySMuAXoUzTgny+ZBC00pG9On9BEB5g7bq+t11XZsE+Azq6CNLK/VQaAwwo67NE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+frJPqfStz8HdhrGWqh+uqPphdWNNGmaHw0Fj20rd3lWA9zYNt
 kI+hPcE6ooAzb+2s1lRdnbvNQ+eh8IqXwBC3s4rGADLLfUWpHQnMwrUs
X-Gm-Gg: AYBFou3KLr8Jar+KYuOVbEg+xv7rDL4/eX2Wx3w/IY55xHN7ivtD2g/aOtALyUU8ASa
 CcLXEfAcrCOvzJ2W8ynkXSL1/HFSJHF4EOxd5UWmZAAUo/irOdFJuud40n0a+eVINkeyNOtuH5P
 wv5RWqTgsE9p0OF7Inn3xA55cyaYttQGq4ZYkyU8eXcjtX5GMYWyzyqIxbQNrhJKeFl+FUDE/18
 Zr6bn+4qTqUPRFktZKLgKsSNLF4E5PzcGJ2mkwBk60oJx7GdJPgS+47qcwFVtVna4U9sOqMqb8d
 kDkdemAYa/moWPyr0t6BtvN4WMgT8O1zYmB4YKRYlroNTVod4fI9DaSX79BEVHj+SDtlyVgLhcR
 2/eGnOSTzBonXTQyZQJayE1pCKNaxNc3/1xKpVvqwEMvy7ZgtvqmwqcD6cesVjDfZRNSVPcvguF
 uYgR/cUbFPFKTGjefjjLIT4zZPTRoJxk5xzHstyhNcMHyuCzcJfzTCtiB+ZzcNqdFdIYUg465oY
 ZbmSyB7u2rvJ4Rjv6wGNg8FoD6Rk2RtHmkd5zzRBazc6X2Y39C4lIgRZG+h3ouW/tV1fLjCH0Tn
 tu6/G7BSeI5DrteYCKkNfW7jVSo=
X-Received: by 2002:a05:7022:2513:b0:1ab:faad:cc9 with SMTP id
 a92af1059eb24-1b503115806mr9883095c88.11.1794716717145; 
 Sat, 14 Nov 2026 20:25:17 -0800 (PST)
Received: from JMD ([2405:201:d028:10ff:6918:69a4:7613:6971])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm34054803eec.8.2026.11.14.20.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 20:25:16 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: trini@konsulko.com,
	lokeshvutla@ti.com,
	hnagalla@ti.com
Cc: peng.fan@nxp.com, u-kumar1@ti.com, u-boot@lists.u-boot-project.org,
 Atul Akella <atul.akella@gmail.com>
Subject: [PATCH 0/2] remoteproc: ti_k3: fix DA to VA bounds checks
Date: Sun, 15 Nov 2026 09:55:05 +0530
Message-ID: <20261115042507.1054-1-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TI K3 DSP and M4 remoteproc drivers use addition based range
checks in their DA to VA callbacks. These checks can overflow when
evaluating the requested address range or the end of a memory region.

Replace them with subtraction based checks. Verify that the requested
address is not below the region base, calculate its offset, and check
that the requested length fits within the remaining region  size.

Use u64 for the offset to avoid truncating wider address offsets.
Both drivers are updated in the same way while preserving their
existing mapping and return behavior.

Atul Akella (2):
  remoteproc: ti_k3_dsp: make bounds check overflow safe
  remoteproc: ti_k3_m4: make bounds check overflow safe

 drivers/remoteproc/ti_k3_dsp_rproc.c | 12 +++++++-----
 drivers/remoteproc/ti_k3_m4_rproc.c  | 18 +++++++++++-------
 2 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.43.0

