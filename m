Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B6606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p5qk89js;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=azEkNcie
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CA88817AC;
	Fri, 13 Nov 2026 06:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cUSyEbsDrYf; Fri, 13 Nov 2026 06:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EC87817A6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794549605;
	b=ivVZn6AriGzKftz6iF8xu9iyPuorH/JXPUpLmHFfBOyCYzKFjKnje63dnZNioMoKP5oG
	 ED/sgw7KtH1CxqYYwpZ8baUK2dbpP+j4kEFI/qC7NNsdIXZyKQK0v2sK/O4277e1fBAXF
	 9o4kbBHZJryRGdk7G4oiYZT7Jwi6a30WGoxhJx8JuJDTyZ4M7FT9rJNibdVyzZ7Ferdj7
	 EBNppu67xOfKPfh+8jFSsV/O5AwvlnuZGkSZPpDO+y36BluE8FFavmyIuggjqZuyNGMo8
	 6r5RjOQTgzvpeVYHWdXHnI+6jjX2Q1MC2zfn4kMylXlRVSypEfwXWXapP7mKDsXn4RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794549605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sE+mclYHXmY5RFxJr/VF3YpojR/HS5An79HW68AeXzE=;
	b=EsvpZypXQ79+dtBay56kolZZCaf+kqtHaWbjvBOaBstq6kBpVIFCjQ39I9cJL8UqqIxO
	 dCnmGDyYoOwUSe0M8r4IbgDgOEeDGc/stocjlmwNPZ41b6OUE1ChrilWZ1lYjGuhe69Es
	 79YktbU3hjMqmgGsgZrasWqDihBVS5rj4SKRnx4JXQ56iPs4uGZJRfENENnC4gHHnAWGi
	 5mCcMDx2ahqOGrEku44jGE6dkoYwwa88JTbXZ6yN910gm/ugcszCP2KtbkUy5h6tLdkRS
	 yWtUxx/+CMjRY4HYjO1GDl8yvKAvzxTWs39p0Y4mi+pk9+oP/MHkFRe7en47p7Oh4oQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794549605;
	bh=sE+mclYHXmY5RFxJr/VF3YpojR/HS5An79HW68AeXzE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p5qk89jsGR8L22Gz64LUDapz7ArBgolOasBBok8EZ88VGU3UZLiv6qCTNs5eqTv0K
	 dI+nz+i8HxySPkSVkAGsq/IHOh16qVAzpVbN3Cq8rxiyRtkh3K+/ILeOTpIPjFowmW
	 OS8Wk99qVxQ/GyGyuaAgt8vtbw+6KzacKLZzvBBQOokJj8aCVShS5+vnmtMpbrBMnb
	 7qhI+RIfbFLObbe8Yio2MzS/yP4aL28IBaGPqrY7jqd6zHcimxjgv97KusgeehSwli
	 8KnXLrXN663QRcigYCO3K/fLOEfEh2ZrGfZaoOQ2Yt9bYxUQB7pz9OYAS1d2IcfNoy
	 JVRpWGdkQSf9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EC87817A6;
	Fri, 13 Nov 2026 06:00:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2599428C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16C2640D9D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7MIpgPX7kBt for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 06:00:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE80440D8E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=azEkNcie
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE80440D8E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 06:00:02 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so193275f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 22:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794549600; x=1795154400;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sE+mclYHXmY5RFxJr/VF3YpojR/HS5An79HW68AeXzE=;
 b=azEkNcieE3wL58VPQLsTdWbxQr7G4zH5HtFkx6Rs/DJo7fEe+T9me1lX9KT8RWKObj
 /wuTjURTHQmp1qMt0bUuaeX9Se8VmD8qzxKMivZ3fJWmwBJs1iB73arxzZ2IjD3bIkx/
 zBUDZBevV/yor6eDxZnFP9qqtNmoY/e0UeCsEEojT6W+Tl+rzULHbT471eXJCcivbKuK
 8stDcCXqgfmTk3CSwOvqmPEeX/f0LPQgY9EpyWvhLZ0n0RPvKqpYCUETc+2LUsUXaBdB
 sWsS3JsMHS0OZP+OCvUhHjLs1BQzCiizzDo+abJb4I6p4nrUPjkMwBSRI4dUjN80XlLg
 z9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794549600; x=1795154400;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:sender:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sE+mclYHXmY5RFxJr/VF3YpojR/HS5An79HW68AeXzE=;
 b=muQva8vM7ozJjNKEt4dQWNUuRDLjBQ4djXXuAFKgKk62rC5F/TrMMeARaCKhBm4hlb
 3/6Mmk88YuA8RNak/NwlZ47Zc5oW5ucsgLU4gJ3yy7p4N9hMdmn8pnkx2ZIwF8DvRyq/
 HueQa0dOaZ5wKNQ+uMmTKQSEKn6d+gZc00oPohtVmKAVYwfoiiMlKGQq2PmeL9qxbd1k
 xrqp1f5Hxj0Q/XXj23E9sxPhiM1PNi7SutEtgdu834Rs51jQXaKiKVXd/+FcErq0tK13
 6J26LFinqwjyqUvwTRvgq2SWshXxCYaqmcpCF3tuKFf7b+7K+OcVDQf/UcuNqA5lr0y4
 mr3g==
X-Gm-Message-State: APuU4Z8HgDrQCWtRi4R3sp+mrVSf3TfFfmaqL5Cge3VOY4qy/qUCKQOX
 3n/BFqJcUkiW+nI2SvtqzBxU2pal7Yq7xolcBg/qnauJJmgPeECD8n2GhbfNku27
X-Gm-Gg: AYBFou05qw6CtzbeqGOEC8P43iNmhGOR3C8Qu4OoepcMzc/MePB470jeQbBjR5vc9Zp
 poPDWeq3/IVUEegnWWIg95kQ7mWA4uj1FqcZUiNhpVTenNG2biOXeVkl9DsUFA5B5LClR8w8d1u
 Vpy1NEMc+7uQ+pIbxUs8hA5GGUhBXUM3w4ucIYgZlu8PZsMwtPKUdfvfqYQxIFrLmivBrrgLIIr
 aOoR0bVIAS7tqFGJ0zQd5RzbbegDb+IFz+v+0kj+iaxwSql0chzygByqN0F0KFPrj1FYwiKldGc
 EHTMwyx5Xpakf1P8Hrbq9h8m99yYHUuN9K+o57fEuM3kndH/ilzckxWkAvYpf8ro+u+Slyopnmc
 Jp33fbY8fArE8WG9jJ7ch6tADpeSi2slBl8gkQ0ogFYVVntT+z0Gto4zaeOqyaVUEZhi5Sktnff
 ZMv6oW3B2Ta0Kg2yO/Ft391B16TLeCeM+IkANEbXsYaQMQTfo32+liezwgLy5KVV7ub9k3T4Z2f
 dOBwVlnvMxY16cnjmCiu2/udsQpiHj34DNQ/s4Q2N9mWS+pDQGo5J+3isQCVHUTcvkEW79JYypP
 gxFOc5QvKyELD+CLzLH7nUYpHE3IcQ+CIsFiwbaO
X-Received: by 2002:a05:600c:8b05:b0:4a2:a9:ed5a with SMTP id
 5b1f17b1804b1-4bb55a66011mr26907085e9.8.1794549599973; 
 Thu, 12 Nov 2026 21:59:59 -0800 (PST)
Received: from [127.0.1.1] ([151.51.254.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm32906355e9.7.2026.11.12.21.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 21:59:59 -0800 (PST)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 0/2] arm: mack-k3: Kconfig: Hide remoteproc configuration
 options
Date: Fri, 13 Nov 2026 06:59:56 +0100
Message-Id: <20261113-remoteproc-v1-0-be4c313f577f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyn9moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3aLU3PyS1IKi/GRd4yTTRIukVGOLFDNjJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaAMuYz/9uAAAA
X-Change-ID: 20261112-remoteproc-3b5a8be38d63
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Beleswar Padhi <b-padhi@ti.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Judith Mendez <jm@ti.com>, Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looking at the recent Marek's patch [1], I was wondering what the purpose of
the K3_REMOTEPROC_XXX configuration options in the mach-k3 Kconfig file is.
I came to [2] and related revisions. I figured out that they help to provide
a default optimal remoteproc configuration based on SoC type. However, having
them visible and selectable/unselectable to the user can lead to unexpected
configurations, and cause confusion. Instead, if they are not visible, they
do what is required (provide default optimal remoteproc configuration) with
no side effects.

There are other ways to achieve the same result, of course, such as with imply
statements under config SOC_K3_XXX, but this does not seem to be the style of
mach-k3 Konfig file, so I preferred to keep the original approach.

[1] https://lore.kernel.org/u-boot/20261108161752.2430291-1-marek.vasut+renesas@mailbox.org/
[2] https://lore.kernel.org/u-boot/20250210202944.1071931-1-jm@ti.com/

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Massimo Pegorer (2):
      arm: mack-k3: Kconfig: Hide remoteproc configuration options
      arm: mack-k3: Kconfig: Keep SoC dependecies sorted and readable

 arch/arm/mach-k3/Kconfig | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
change-id: 20261112-remoteproc-3b5a8be38d63

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

