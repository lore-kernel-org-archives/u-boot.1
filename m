Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA715606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ejddufm/;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=mX/65eQ7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A798C607BC;
	Mon,  9 Nov 2026 14:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGQZ0Z3dFVW4; Mon,  9 Nov 2026 14:29:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2169607B3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794234573;
	b=qMV+9Zh8BuF9HosqpLZg16SnD286eDtN+17qHNcvkIX/JNLgPqxkqYxpwnNEjZ3NtiKH
	 if6WPcXnz6/VHU0wMYRyPSuSyEMNf6R1r4LF0gcceyJW22wFFoorTDObPuNhHJj7CslXr
	 HWKfLFxFKvFz9wOvo60uxAf2tY+Obhb9e8Dqs3Y+VuJ/mqnjcQh7mycQDj9GbNvk0qPlI
	 xm7cjL+86jVcfKSXIla9MhosNsEr8g09owF6B0r1EPTUDR1BvUkQ37Uj+WgDr4heCda9P
	 K6zLOFat2we3OE+B7tBAeRvRlcPzuW1nfujeY29Nmhob2dKc73kXr0TnSBijrervtGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794234573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kfaFTk4rCU5MnMlJQDvXkN9GOIw4QZ2mfndciwNYfKI=;
	b=A96nXQPwBfe1BM5CuH8KVt6IVU7Ug7ZSh/tjFjoIvPNcXF+O+0Gj32zkVZFC9gULZDH2
	 k6TmAvWXDcfg/TAmBBpjmBNIcMvfao7Nr5PSUwiwrZTqfOqH8v1UkFAObk6Xkn8lHYCfV
	 ehqTzhI7VtYQs50jQTA3fPdGpfvOvJeqOX56pNi/BGEqWNH83p7Blh/CQp2mo3Qb3tmWe
	 lC2ng1rArd5yBSTzr20mPKvyXhqj80bCuO6v79IBIMkgOvisEmJc32wHjO5WNB9pv/SD4
	 5yE19HbvwRexz2OwhCNLQUbQCiHQyNUcU2GxMXREYG8q062zcwk5ruWRljTKZ7loIOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b="mX/65eQ7";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794234573;
	bh=kfaFTk4rCU5MnMlJQDvXkN9GOIw4QZ2mfndciwNYfKI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ejddufm/zsxJVGqTW+HMBUcefLZiJfJ5qOEZBnRTBoxLx35YuyhEaQVRZyXyW3NM3
	 YfH9hV1tjYQ5cX464KgSDDcOgxQhP0dvWhk/5I6VgGZnRIJGI6TE07Tm0W+LnXZwO0
	 M4jlHdS3Q1Bq1GDEKG4fApkBNMZzeRcTCIBsPRXmT0cH9U7TM3wsUthAuDLrnlj+F3
	 3q9oAXj1AdYZtTL580wW5ABmshSiKSx8sToprrgU48vGwwYNLijMZkxOedumpZnfWZ
	 sOMBv1NJxHI5ve5Mgfzs+5pIwYV13FcW1C70Z9eXU8Q5xi0T9EEO6ku2lA7DdjHMM/
	 AjaHQmLGaqWPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2169607B3;
	Mon,  9 Nov 2026 14:29:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9F01111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA0A7607B1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBUkBc67PhxF for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:29:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8722D6074D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.175
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=mX/65eQ7
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8722D6074D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:29:29 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNX7H2mFvzdD8;
 Mon,  9 Nov 2026 15:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794234171;
 bh=kfaFTk4rCU5MnMlJQDvXkN9GOIw4QZ2mfndciwNYfKI=;
 h=From:Subject:Date:To:Cc:From;
 b=mX/65eQ7PW2MOeqsyfGHNkgDE1q9a3Gc8IaJdbbAYUMpHdnadCozYtu7hqw8Fdq5C
 7GlX0VSqz2SLrZnUhG3K/knw/3wdFJOo0ApBlDc1rETRSHrpAf4LCFlSbwwlCOQRg3
 cfYr6bY8/chExxqJG4HT0WvuWCCxm2tXj84tb13ZoVoV6n3Isc3HBvS8caphrvvOav
 iVqECSqo8/dz/GcOgkg8wNZrMNDArcQ/azHb2HTIj5lY2nVy8JrF+qR1GC+3q9pxo0
 IF+RbjAy3YxkfgBVtEbdRsjMbdZGJ3GP/18J8C0rbfcnljaTbkXWWJ1HuP3RzwCYcC
 kbWHFTFBab47g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jNX7F6l5jzXrd; Mon,  9 Nov 2026 15:22:49 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] MAINTAINERS: update entry for Rockchip
Date: Mon, 09 Nov 2026 15:22:26 +0100
Message-Id: <20261109-rockchip-maintainers-update-v1-0-d8f568818a1a@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQqDMAwA0F8JOVuwnRPsr4wdYhtnNlZLWocg/
 rtsO77L27GwChf0sKPyR4osCT3YBjDMlB5sJKIHdK3rrW0Ho0t4hVmyeZOkSpJYi1lzpMomxuu
 l61w/DhNhA5iVJ9l+++3+d1nHJ4f6LfE4TlnYVPx/AAAA
X-Change-ID: 20261109-rockchip-maintainers-update-dd534426b9fa
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, chenjh@rock-chips.com
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kever has new duties at Rockchip and doesn't have the time to work on
U-Boot anymore, as confirmed in private. He's suggested someone else at
Rockchip could help reviewing but it is ultimately that person's choice
to do so, so I did not include a patch to add him as reviewer.

Simon is not part of the community anymore, so update the Rockchip
MAINTAINERS entry to reflect that.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      MAINTAINERS: remove Kever from Rockchip custodians
      MAINTAINERS: remove Simon from reviewers for Rockchip

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)
---
base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261109-rockchip-maintainers-update-dd534426b9fa

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

