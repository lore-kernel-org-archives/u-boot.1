Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2FBCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91BB3414B6;
	Sat,  3 Oct 2026 13:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qHpNc-6WL0D; Sat,  3 Oct 2026 13:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AEFA5414B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034853;
	b=WJOXLNo/kSK8Hc10/K+GU16dCJThiTh97L/wsA83Buh00BHRh/eW8N+7zUBFTOvBhtvj
	 y/70NJc/mGcjzFg7CCXl/T+FTwd9ukMQYEK3waEL0B4hghuuReD1aqUSUGWy3n4KIl2R1
	 lHixGzGvm9/1YVEfBkld1yAFOXr00Mjjal84ji606HYox/5mGtCnsHeniCHBPwsN2leDk
	 OGMFBlUFWsHN/5JAC6vB0pumJt/2FWSh+026qEAEL00aH/ZjmcfhQVIhbJwJne1k9JZpD
	 IImuLKsDfKJ0TmIf9HU85UXEgtDjPoWpadL/KDmZmJ7jOeCS0j9fz1uGOSaeVK//vSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
	b=VYeQJ2OujUXv3NTpY0FsQea8SbkxfpLtBDIvTulM9ZT4M5o0MfBph6Vps+LP775HlJMG
	 8+ZlEqZn2q7cPA92Ch9oNUDQQTEIXl1Oed4HQ6SJUVOQyzkVOSCh/Ehplr91g+j9/NKwT
	 XmRfyf1sCVKmiyEpfXRbLORrjji+k+kLSlgz2lagRwGxujhwJxaCRy9JLysfxed2kpnzs
	 sCvjjZ8yKA9ouRbX1Lt8SUqKHtNs0M2z7lWQ5soD3kN9LqjuETEOfdfPP4AUIKB/3igSO
	 Oc1GSG9TAjgSJ5w5zntKOW+bR2z75He79I4pUHQOOWLWkJyjMKD7DJ1dEl8DxqZP5Tg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034853;
	bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qAXwVe4djAfbuOQ3On9bIaW0guhCoKWY1Qcfe20RtDnXnAqi36Nae2zqHM1sIulT3
	 aTnFga/iELBYuamCM3xmi2YJBHJGLYCt5J+JTBxGgnQzQHIwn459gYmqOXHSTUetlA
	 0ikzm3jOp+uLM0Ru8vKQ1NoA0brjOemlLQmE1zjPbJhkGj2ztLcS4712o1n2zaWkz9
	 jDR7IcOIhPP/sD5meQcMl9Mf6QlFkb0m7tlrK9qeJtq3JOybfBCWcykQKQgybL/dAS
	 PC4iu23BpMFn/B1LMiS0C7JSw7WJwk8JkTnxTRGp/YUM6P2H9erXZHr0EyZWCv4QQC
	 tiIzuonveWJOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEFA5414B7;
	Sat,  3 Oct 2026 13:40:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B51432F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D60160689
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LiJoCK2bSSvR for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 686F260675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::24"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034851;
 b=s6Q83N3cI6e8eJOkClLL6qWBwysOe3tbcQtWHdb2W7Z1azds5mQuuQEJFy3GpbnxHoKI
 n9apFAZZ4PhywYabqUSAB9ynT5fJub09zWng9nXdX+y5AvWPR0hN3M9efNFTKY/qKlHEe
 SuyKulJnXN70CBUrleZsxj32ZjVrZixBZI7TpTOvUlyeeje7A381K7oehbYhRya8sCLrP
 WSvkPC9kP5mmKILV3RJFd/YpuMCkby1odQ/TKbjjgobxR+LpIIOaPi7YhR2s9Z3ctdC23
 QvAnchv7xbWkdm5RVbFfkYkrv9Azc30yElnskR0Ie5fAgBgwimfSw6PokxHW0cC3omQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034851;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
 b=X4CM1gquztXn5R+oofvVzeSHs09drD69xvE3+3HxwQexQQ1FfLXtSWzcFSweKb5iC2/d
 EQASMjlmLqJvmkDd7qGiI5WTiutBkuYn+0eAYIjfKUm0SA7JllcHFco7qhrGewaTsPpeP
 NFsiYkko1RfciT00mgtKOd+PI0VePQtQ6lvdOSEc0jRA7O3U8JLeMc3WlC0LDQbDazEM+
 zuw6Gnmic3U23HQRDp/zaUE95wMTUZ/EtYnHK0QaQ9+VmjCE4+30ZZRUZfBtJMD6jT0TV
 +V87J10gVRKA/x46aSbQFN00+F+CR1oyhMPcP3mpwDqTLKaon9C6aGq9CT58k5iswSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GaHmNyhO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::24; helo=mail-ed2-x24.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=GaHmNyhO
Received: from mail-ed2-x24.google.com (mail-ed2-x24.google.com
 [IPv6:2a00:1450:4864:33::24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 686F260675
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:40:51 +0000 (UTC)
Received: by mail-ed2-x24.google.com with SMTP id
 4fb4d7f45d1cf-6afb0063e63so312582a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034849; cv=none;
 d=google.com; s=arc-20260327;
 b=LesElqUdolA+XGg54Fdt02tuxTS1uyR6Z9fCEW5Z5oJ5aWJEj0kdvtS93Dse4zQ63T
 TOpfOXozObPRruU3RDth6l/KBfPL2xF5hX10xNmXUGPIU9g48yP63wwVDwNcOOHeSVvE
 CT5WIbLZTQs/k1t18qhrGkUq63Ha3ONifgEcivLJWj5WHIGcz58iSV3x7vpFOs0HzuvH
 ABl/N7HegaASDYtJhY0s9rcbsL9BeB4mPENHJHhoyyEulkjpmafuK83SkNOz7KrO1qy1
 yQURiJ4ve8D9uDyP5gylCB+JqKSWgZNWxxz6Ri6BPbjiKYqZSaizcu9Z0SHlNOHOhhlW
 iANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
 fh=9XeMypDVKZ/kU1g932ZbVvMYaK6z9Cq2dAkZ+eAi0OY=;
 b=KTNZ/hJiYM8yNgQ54BWC09Kimj19yn6uQBU1PP11sDnxoecC9UFmE1uOMGJmlqmf2u
 RPkjv22Gv/qkzBxTBPPQYGF/lS6uSx64ULqS1jKPic9QfgoHtM440t4lt8rqcOUZ03iO
 PrCVPUVLAES3ijIAVVdEdC4TYBkvNbMhsGktxJPpXkmdhz8lVb0sHtinuMEskxlcAlMC
 8/Ou8Ijr2+lSqyDQHaX3n+4uy0Sk6f/hcFsIm1PAuaAEYkQe+r1c97xGcKDTecJK06l4
 zDgFjRkAooc/YHjMxse7h/tnSpdREBXhjUMdY7VgxQNqKny75eolH/2nKpsxDdWTlPQM
 h5Yg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034849; x=1791639649;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
 b=GaHmNyhOYhUF4tMkE17CblJYN6sSFoa3hkZxoFEsCV3wYKPW75jACSCJ0xycGzs09s
 0uLiV3CO0jURe/+1p0YcNNWiAv/rpSElNJ908QFx37FvjXyo/e54/qtiqbvKx/F8FD/4
 waO7onEhp7oN1hTbfH9QuT2ul69+ROWKgO6I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034849; x=1791639649;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RZ89QnGmlbJ24I0OPGFoZ8LEkRHqNfyqLQ4+7PWMYZs=;
 b=oECn6EvczJJtm9s4NBzjTspGQm8/LblWYWdXnvFH3uppeN13wXj5mNdj4nLy4WtYKI
 4oCJgwRzNCjraBuhwYXdU5Jcnts+l9BaTgy7iJYcqlTY/d8oMhboN7izYpELDPLVLbrf
 NHl1OfiAkZH4md/ye8F+dO7GGUrDVZsKTVJlP00/ds9bbSSOXU5vG4KPEhBgZJRMpwL/
 ot2C8GvDDpHyXSZyUrUUmnsIeBdfvN0w0ngoE8KWbVTfH2Vgsnw8wR+tzXNrv+CqezPf
 IZBPjCAMHaXgGEIerA5babcIDNKqlr1zmNZAfGS9kpMWLWnT/dlq4gzOitDzmMHebpFx
 l5jA==
X-Gm-Message-State: AFq9FYJ5xMc/A666vLnDNzTlBCv9U/+KrQci6soMoWoX7mOTBaoEZP+L
 pFj6n9zH/BoJixEth5HkvF6jnU7OJUgyLxlKQyeEvvtEjFzblCRf58HNlqIDcPmPT1kKCsFfbzd
 YY2EqPRfplusjEJqOATxGmQfNhqbHGDGVpKvC+oWA
X-Gm-Gg: AYBFou09rZ7/9eWdy/wVivlTtlPUVnwJrwkgVeHavq6vPjNX4S6LV/7q0uZa1wb1BdP
 31wJXAsx0EkZalS3eU6cKbagnb/GuS5bC3DAV0XyH8cS5J4v1trr8WGt5g5yFsXwWsHIfBilmVQ
 SYfVpVQTFWB4imhGiPyNX8orck+mn07mHj6DQFUjfXnz0ko2+4MLW2c1Bt3roo00cqccoOyi8JM
 Zld84Ousi+ODzqSpl3hUs2AhIxuUty6l6KQ7hQ7JbAtPk4hc1sMVUH6q1yXWHreozo5ArIZ4/nm
 IZF1eyw93dW+CCFcvGG5esQRo4Ug2XiqnkWbVAYjIPryhKNvsdL6mMA=
X-Received: by 2002:a05:6402:5414:b0:6aa:f74b:dbec with SMTP id
 4fb4d7f45d1cf-6af9e046214mr5072080a12.1.1791034849262; Sat, 03 Oct 2026
 06:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-5-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-5-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:40:31 +0100
X-Gm-Features: AclHuK9z1A0YAc75KGVVFnoeqDGzvkMw_cGtZKj2Ws1guBo2biKjjURpqddY0ZI
Message-ID: <CAFLszTjymnJaaszBovsouKK-XTH_gCb_zJ_auSDsO08xGx_qZQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] pci: gt64120: drop the duplicate
 GT_PCI1M1LD/HD_OFS definitions
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-02T07:31:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> pci: gt64120: drop the duplicate GT_PCI1M1LD/HD_OFS definitions
>
> GT_PCI1M1LD_OFS and GT_PCI1M1HD_OFS are defined twice in a row with the
> same values. The Linux header this file was imported from,
> arch/mips/include/asm/gt64120.h, had the same duplicate, which has now
> been dropped in mips-next [1]. Apart from that, Linux has only changed
> the header's SPDX tag since the import, so there is nothing else to
> re-sync.
>
> Drop the second pair here as well. No functional change.
>
> Link: https://lore.kernel.org/all/20261001053016.76578-1-aristo.chen@canonical.com/ [1]
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/gt64120.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
