Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8A606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ev2H61q/;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=YrEqD/+w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 269336075F;
	Tue, 20 Oct 2026 17:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nRKMP-_5HxH; Tue, 20 Oct 2026 17:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C84B16076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792517161;
	b=hgRqah8vhgfy36krSr3V30dn27XrNbFJNxS+iYBa1NGUW7kRmzwbZ50AriwX3OwlUaFp
	 uocPCCPjulecUNxgQ4iVBJqmQa+x5hsoOsgCEtX/RHz0ESj/H7RNJA0NBiwgG1/tO3gmL
	 y9G7ZMwDFq8JIYVlQePHCyJLfBows6teY0KNlBVgbKJhoE8hiSjBB8JRp/iAip+yN/mqK
	 yRf1eVBdmpFsgEoMeIRnY4rXbih0Cu01+t/PLbpbb56IdxLrY5QbDlcWWYVP6mLe/R0mZ
	 cA87e3pXZ0cCe2zdELH7rv2KcKiMbnc6CVlKERod90DVrOF6VpjGSFrRxK4MN4ub8Lg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792517161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GeNV8vXp98GD0BRJ9CwGllqwdtBQVpuNwCtocQBlnS4=;
	b=k4cipWhH/PS+/LiMNK3jOORVFIz8hbxgAeyYKxZSg9X+HFlKsoVU6tfH8RUOlEc7uKtG
	 J6TLEL/tUHRXJlARRoG+GGK8C//S4JU2/nlN1AYe93cxGPUvBV80zULQNUPEP5zsssF0m
	 uqMsi1zfPGEyYF7QofHVfe/yARmPBDLEhhUO4EbzKxpK6ywwU3t085Ip7BdkPxANPteob
	 h3i1iJQgHaXV/1hUbHzm4n/GhqWjQOxWfYY6dzncM9cbbsGpIJ70x/scsE98KpEMVEu0T
	 YnfyNm4MhKKYpc8gAGe19TF0BLP40h1kT7vN7QesSS3ByEDUPaH+kn4Y6Arzn7UOuDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="YrEqD/+w";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792517161;
	bh=GeNV8vXp98GD0BRJ9CwGllqwdtBQVpuNwCtocQBlnS4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ev2H61q/VxyEgjF2lzJBXf1LIj7QcTCGkD0DBKlgnDT0yKrrGTFlZwA+cffzZsOnf
	 v5qSDC76PaufQOLd3ndz76QtRWFP62HS5M3yvkoZMdDuNdfHiwhawi87JO/u33Y0mK
	 jPfN1kfXkYWdzK4aKqxlsr4+P7PLVareOzlo8Z+hYduUrDZngtG/P2T9/JPRWa1Gpq
	 eMEAFlyUYicrZVAgUhxgL12QlgOJZI9/r4i2UvzWlfspi4tx84u3iAqP+aJJspVGbl
	 /FR1BlaiwYyWLRreh5XSHE4tqaLC0IJh4tk2nKMV6b0wXtpdgfKiBja8xRgYiHgTx5
	 X7oxMX5w2B1Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84B16076C;
	Tue, 20 Oct 2026 17:26:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3701C3A4
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2794960773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMHjEyOhn-yu for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:41:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EE856071D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514481;
 b=ILZx6kaVze2VvQEapuSTIbP+5563ixWZ8GmnG6BcqRuJTYCwXPLjj6iSpO3aYxmCHSqm
 Syrq6KRJZmE/a1KY7n+ZFCyiepbJUGE48GyJ+s7yjoAz6KpIURkcZ3Sf3OoQRz1YwKLcE
 ufpuF4toksAKuGev2IVGTO+FmREbx+WhJPYecYfuptHkY27AoRkQMoyYkuA4i9jJCH/gE
 g5OPmtIEPqIG5GRlGaR147UAeRU5YPLc1drHrhIT42efsEcAWPgq0gFY8KxF02eanrIOo
 +p826KWYBFl7D3u336eizwfvZ0alwjzugww6q2JLHt63G45ULP1l+OQDa7TDuFB/xhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514481;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=GeNV8vXp98GD0BRJ9CwGllqwdtBQVpuNwCtocQBlnS4=;
 b=Vp5+p5vy3dQWbobwCyb/btq2uiNIcVOv+Bsr6jLSi8DD1VKlJULot4SqOHDfCi+j3CHU
 tgBFs1Gu32ht4RrWgxW2SpxR2lyi9IubGvFTo624m61I5LnGNqi3nigQk3cdXBIS7F0/3
 XRP73NmbpbUxuGaqA5fizSAC3rLwi+FEq/z53jlIGySiDfI/0SOKpPKL5+BluLa156HNG
 BOkufBIpFLjDqxdDLatoTg13grRZU46vnsvNq7BeIFPjdXqFyfkXdolLWeAw+VILPKcYs
 HMCBS//BK9wVDytST+MzulcjKBMLZU5BHK68bEvH3EkZkmVUaueDcHRU0ILhcmcsl8A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b="YrEqD/+w"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=YrEqD/+w
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EE856071D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:41:20 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so26802165e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792514478; x=1793119278;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GeNV8vXp98GD0BRJ9CwGllqwdtBQVpuNwCtocQBlnS4=;
 b=YrEqD/+wQ8VDEh4zLd2FG57UsuWfccsQ4dDlL/b75oQqj7SXLxy+z4ik248GMavEB4
 d7taBOfGNDnmHa9tmRVZpVezIEX+zUqzne2U3KnveI+ezXW73O32DF979MAlgFFJ1Q14
 SY6AqR5JDJfvhrsgn4o+3sGP9gePPYcvwzR6pSbV8p9K/6m9MOjgb+M/9SXp8LsZBnPK
 Fm+YU+Mf+70bJRo9eRevWPfw9anR0CGEnoUkWzp4bXczN6VXeoOyC1wQQdmfYuK4oq2b
 4qiHR8qo0xkpMWmWgmwW/Q8pH/4y1xHK2f1AExLBKt36COmlXgotqryX/nHaLx32s2sx
 6zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514478; x=1793119278;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GeNV8vXp98GD0BRJ9CwGllqwdtBQVpuNwCtocQBlnS4=;
 b=AKZn5wfOCejTXLf7JisUOtrctbsBM+SYRR0dc6P5xt8WOaufnMomiqbmoPEfNjFg9u
 Gm2UbEs4+DJuZ5OI4imp2V5xdKweKEsKny4Z8bnRVU1piU1F5CZ3815GjHz8pCIRSDZn
 at9DbYlHKmMYR8WfkU2abtDYZ12JT3Uf8/6RDRQelbJxxmkWZ/TIy9ZV/1nBdfeHkX69
 wk683cXjo0EDwfh0BwcxOMH9u4llfwPPTqwh9Z8JozyaI/F1WPW0TJEgyphLjmL6DZB4
 THojcNBu/AmrIs5Na/janqMdS1YbBdbeuLBSZl9Cwtpck1dL3ZM1VNkpojEe4ObtJmeK
 2XhA==
X-Gm-Message-State: AFq9FYI17w19hxmR8eODzXP1PW7gHKFVxXEVzkNtMSHhbzEMjTSFICHJ
 L08ujsTCoR7npkXZiQfGe6ohRmpETj+jMy/gYfPsuOMvxZ3kLZZ2RPEtl+8uasuwJmQ=
X-Gm-Gg: AYBFou0kjp2KlRpP9pJTwXjb5lXXA9tVmxsRCXte1MxkYm4LdrpXAQQFnfMgrCXc6fX
 oaPWrQxFYZWX9RUYpEaJasr9NRkYtlbRd0izsUK7G1Um0fNDaPSRILeDgCQDqGdLOt0L9DJi1ex
 Ev6xeyeAp9EOEqM3WPv2aiWmKZDidLB6E20TAGWg4PgnxnLDbWdS19NV+lkpyga4hXlND5pnF19
 L3mV6tG+UOFNI3BvtHtHI8OdlivaguZH6qHpCy+VtYsdKiLU3Km7wFZq/9pTqvXH83Pw2eF8CXk
 +EYA8oZmtEA7wSh7Jkd5vU0V3gPiLfQeTs+MOYyIGcqKqJF8P4/YFbAizqnXMLf4P6y/l4W3iSF
 lybYG7Adn0NmHrRUaaQ6Xq7VyHNDc3AAeIWQ99xaiRAQ+QGeNJ0SIgGlaHMmk17N/yto24M9oAF
 BLdvUFMh5/mPTMreud74p73Yrs808DItRiLPypX1LMnsVW8JFZiq0c+Kkl9kNna4KLAi21TYBI1
 7qooPxgo5NAKPsC68NQwJl8S4f3FEcg1NVmZyDZRveqPD+dagB9zg==
X-Received: by 2002:a05:600c:6095:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4a1dfaff7ccmr177212155e9.4.1792514478007; 
 Tue, 20 Oct 2026 09:41:18 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae.
 [86.98.194.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc10de99sm643315e9.1.2026.10.20.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:41:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 00/23] spl: fit: Generalize compression support
Date: Tue, 20 Oct 2026 20:40:47 +0400
Message-Id: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ7CIBAFf6XhLAaoUPDkfxgPlS4Woy0BJJqm/
 y7UmGjS42TfzkwogLcQ0L6akIdkgx2HDPWmQrpvhwtg22VGjDBBFOU4uBs2NmI93p2HUPZYMEp
 kzWWnhUH5Mx+MfS7W4+nD4XG+go5FVRa9DXH0ryWbaNl9C81qIVFMcKMkbzUXAAoO5madA78dI
 KLSSOzXItctLFuYBLUThjc1b/4t8zy/AbHnBGAQAQAA
X-Change-ID: 20260915-spl-fit-compression-62108358dc6f
To: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>, 
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>, 
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10650; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=J/wJTEOhBCsfJ9ixGVJEvYP8xxL8oVxM/qJL/p+Gx0Q=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdn7ngzcU1iensn58oXJ99zvJarNdzoyf7Qou03NdLJ
 kzd+27Xk46JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCmeqYmI8PaNSu3BzkWFJcLSdqYBge/nX9D0Xz5uROCK6qlDgX18XxhZFj+smL
 L6Y9Vpss43X+e+MXUwvC0meFS/I31Ozg5H28wmsMFAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Tue, 20 Oct 2026 17:26:00 +0000
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SPL knows about multiple compression algorithms, but only two are
hand-rolled into the simple FIT loading code, in spite of a nice ready
made helper already being available right there.

Generalize the compressed FIT handling code to accept any compression
algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
requires xxhash in the SPL but which was absent to date. Where SPL has no
decompressor at all, refuse a compressed image rather than copy it and
jump into it.

While here, also extend binman to support passing a compression level via
its image templates, which helps squeeze additional ~15% size savings in
my testing with Zstd level 19 without impacting decompression speed.

Let platforms which build the FIT that SPL loads offer a choice of how
U-Boot proper is compressed in it, via a generic Kconfig choice, with
Rockchip as the first user and generic-rk3576 turning zstd on for CI
coverage.

Compressed external data is staged at CONFIG_SYS_LOAD_ADDR, which many
boards keep right above TEXT_BASE, so a compressed U-Boot proper unpacks
over its own input there (as Quentin hit on PX30 and RK3399). SPL now
refuses to load an image whose compressed input reaches into its output,
and names the addresses.

SPL size impact (text+data, bytes), built for all 413 boards which load a
FIT in SPL:

- 387 boards without an SPL decompressor grow by 8 to 129 bytes (median
  96) for refusing compressed images; 4 are unchanged
- boards with one:

  board                          base      v3   delta     headroom
  xilinx_zynq_virt             124886  124848     -38   71760 (36%)
  xilinx_zynqmp_kria           126531  125933    -598   46099 (27%)
  xilinx_zynqmp_virt           137366  136768    -598   35264 (21%)
  dra7xx_evm                   175214  176053    +839  330827 (65%)
  dra7xx_hs_evm                168233  169052    +819  332884 (66%)
  dra7xx_hs_evm_usb            173793  174612    +819  304284 (64%)
  tqma6ul*_mba6ul_{mmc,qspi}    35874   36664    +790   24776 (40%)
  tqma6ul*_mba6ul_uuu           49903   50689    +786   10751 (17%)
  generic-rk3576               105939  132832  +26893  129312 (49%)

(tqma6ul* rows show the tqma6ullx variant; the others differ by at most
150 bytes.)

The xilinx boards shrink as SPL no longer reads the image type just to
print it. The tqma6ul and dra7xx boards enable SPL_LZO for their
multi-DTB FIT rather than for the payload, but now link the decompression
path too. generic-rk3576 grows by enabling zstd for U-Boot proper, which
shrinks the payload from 690KB to 296KB.

The tightest boards stay within their limits: pine_h64 keeps 757 bytes
(+109), orangepi_pc2 931 bytes (+109) and display5 1059 bytes (+76).

CI for this series: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1642

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Rebased onto current main
- Fixed a bisection issue with the removal of spl_decompression_enabled()
  (thanks Quentin)
- Folded in additional decompression tests by Cole Munz (thanks Cole)
- Made the compression choice generic rather than Rockchip-specific, with
  self-contained help texts and the reasoning moved to doc/develop/spl.rst
  (thanks Quentin, Tom)
- Stop reading the image type in SPL, which was only ever printed, and
  correct the size figures for the image-type table (thanks Simon, Quentin)
- Added a check for compressed data overlapping its load address, before and
  after decompressing, with a test (thanks Simon, Quentin)
- Refuse compressed images in SPL without a decompressor, keeping the check
  to a property lookup (thanks Simon)
- Avoid linking the compression algorithms table with SPL_FIT_IMAGE_TINY
- Added range checks for compress-level in binman, rejecting 0 and levels
  beyond what the tool takes, with tests asserting the arguments that reach
  the tool (thanks Simon)
- Offer the Kconfig compression level only for algorithms which take one
  (thanks Simon)
- Split the sandbox SYS_LOAD_ADDR change into its own patch, also covering
  sandbox_vpl (thanks Simon)
- Make image_compression() return IH_COMP_* and share it with the FS tests,
  and check algorithm support separately from the container in
  image_supported() (thanks Simon)
- Make the SPL tests compare against their own copy of the payload, and
  size the FIT properties exactly (thanks Simon)
- Keep the image type name in xPL where the phase reads image types anyway,
  via a helper shared with load_simple_fit(), and quote measured savings
  (thanks Simon, Quentin)
- Report a failure to allocate the zstd workspace as an error
- Enable zstd on generic-rk3576 for CI coverage (thanks Simon)
- Reworded commit messages as requested (thanks Simon)
- Link to v2: https://patch.msgid.link/20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net

Changes in v2:
- Dropped redundant help text passage about SPL heap free() being noop (thanks Tom)
- Dropped redundant indirection via spl_decompression_enabled() now that it's directly
  queryable via the new Kconfig symbol (thanks Tom)
- Link to v1: https://patch.msgid.link/20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net

To: u-boot@lists.u-boot-project.org
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>
Cc: Cole Munz <Munzzyy1@proton.me>
Cc: Simon Glass <sjg@chromium.org>
Cc: Francesco Valla <francesco@valla.it>
Cc: Anton Ivanov <anton@binarly.io>
Cc: Aristo Chen <aristo.chen@canonical.com>
Cc: João Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>
Cc: u-boot@ew.tq-group.com
Cc: Petr Hodina <petr.hodina@protonmail.com>
Cc: Bruno Banelli <bbanelli@gmail.com>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>

---
Alexey Charkov (21):
      boot: image: Keep the image-type table out of xPL
      spl: fit: Stop reading the image type
      lib: Build xxhash in the SPL phase
      lib: Let SPL minify zstd on its own
      spl: fit: Look up the compression without the table in a tiny FIT
      lib: Track whether a phase has a decompressor
      spl: fit: Decompress any supported algorithm
      spl: fit: Report compressed data overlapping its load address
      test: spl: Keep the payload create_fit() is handed
      test: spl: Size the FIT properties for the image name
      sandbox: Move SYS_LOAD_ADDR away from the bloblist
      test: spl: Cover FIT image decompression
      sandbox: spl: Enable zstd
      test: spl: Cover compressed FITs read in whole blocks
      test: spl: Cover compressed data overlapping its load address
      binman: Allow choosing the compression level
      lib: zstd: Report a failure to allocate the workspace
      boot: fit: Allow choosing how SPL's FIT payload is compressed
      rockchip: Choose FIT payload compression via Kconfig
      rockchip: generic-rk3576: Compress U-Boot proper with zstd
      doc: spl: Describe compressing the U-Boot payload

Cole Munz (2):
      test: spl: Cover FIT image decompression with zstd
      test: spl: Cover FIT image decompression with gzip

 arch/arm/Kconfig                                   |   1 +
 arch/arm/dts/rockchip-u-boot.dtsi                  |  16 +-
 boot/Kconfig                                       |  97 ++
 boot/image.c                                       |   9 +-
 common/spl/spl_fit.c                               | 172 +++-
 configs/generic-rk3576_defconfig                   |   2 +
 configs/sandbox_spl_defconfig                      |   4 +-
 configs/sandbox_vpl_defconfig                      |   2 +-
 doc/develop/spl.rst                                |  74 ++
 include/spl.h                                      |  10 -
 include/test/spl.h                                 |  45 +-
 lib/Kconfig                                        |  56 +-
 lib/Makefile                                       |   3 +-
 lib/zstd/Makefile                                  |   2 +-
 lib/zstd/zstd.c                                    |   2 +-
 test/image/spl_load.c                              | 972 ++++++++++++++++++++-
 test/image/spl_load_fs.c                           |  23 +-
 test/image/spl_load_nor.c                          |   6 +
 tools/binman/binman.rst                            |  21 +
 tools/binman/bintool.py                            |  20 +-
 tools/binman/btool/btool_gzip.py                   |   2 +-
 tools/binman/btool/bzip2.py                        |   3 +-
 tools/binman/btool/lz4.py                          |   9 +-
 tools/binman/btool/lzma_alone.py                   |   5 +-
 tools/binman/btool/lzop.py                         |   2 +-
 tools/binman/btool/xz.py                           |   3 +-
 tools/binman/btool/zstd.py                         |   3 +-
 tools/binman/entry.py                              |  18 +-
 tools/binman/etype/blob.py                         |   5 +
 tools/binman/ftest.py                              |  81 ++
 tools/binman/test/entry/compress_level.dts         |  12 +
 tools/binman/test/entry/compress_level_gzip.dts    |  12 +
 tools/binman/test/entry/compress_level_lzma.dts    |  12 +
 .../test/entry/compress_level_no_compress.dts      |  11 +
 tools/binman/test/entry/compress_level_range.dts   |  12 +
 tools/binman/test/entry/compress_level_zero.dts    |  12 +
 36 files changed, 1619 insertions(+), 120 deletions(-)
---
base-commit: e36b675ebc4c41f1f4187c46d363d581c371d538
change-id: 20260915-spl-fit-compression-62108358dc6f

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

