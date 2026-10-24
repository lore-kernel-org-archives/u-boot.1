Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF1606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pXFagcFO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5GgPEda
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09CA68166C;
	Sat, 24 Oct 2026 10:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y2keaCy86Wxj; Sat, 24 Oct 2026 10:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3BAEF8166E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836782;
	b=ka32MwDZzTCUPJm7Czogp/SDhGC79c8FfGFeq03kxdwOmH+UhShI+0MhPNZig69Rn+S8
	 V91APjQbU3VGOHI33LTM+kZ8gKkt1UfQM4Z752FsYmWS4zchxUDOAdrv85+dImr9jlUKI
	 4oCu2CxPZGgKPzOG2IcPbK/MGXcWhScBZHNq18xYn74kCoaKpvLojJTa5FUXdxmcu16Vv
	 0pjtRcQx5BkU7fSLo0ebE9usS1yEisnh27DWF8W6HMoT/dFVm8xzduRKF74ErnqZ4x1Wr
	 yYuYLAKM8Rv+5Apl7ESeVXU+G5fdrRp7chQHUiyy4zLcBC5kCNvfe6f5V/NdHYvf+/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
	b=H4aRy9KmXIxzhwwwlu0/jUWHJTgqCg2Ts6AkbRZQwx4ECuAHck4xlPCmcOvmg8IxRHMG
	 EqMCv7kVjohgJh4YVetBB2ES4Ut/uH5OmmML7TPdBFEpLr7niJnFDhrDIeMCuxTA+XTEA
	 gpjMxHsfWJ5WvYhGmSOHsqwE6CaVhLXi6N0wbFZrNqDvRSVC9hV5nCVUHyvIXwab9TjY/
	 eG+bDnO7aLqQpwsKJayvUm9fx/BEpwuMYLF7TiABxUQn2HcyGElG0xtxMpzppICLJeIrS
	 mQKPyVH1t8R/5hXJjegPHa7g4Y2huJlqFqQXn8SoyFekhgEDK5uWgEDcpchsNR0jkOQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L5GgPEda;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836782;
	bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pXFagcFOXjhCFWV2DJCG3AtdTCAiWpqMW37706HosYOXvs5/qL2puwFsBCk3ae79b
	 rHkcqKtOEoQcxwGRat7BFtQtZFj2mrpSdeOBnzsFJWDDrIivhmhK/quVpTF9hgY3w7
	 8qJ+dvlOW1/2faQXt5o8tWnHjJIjolOqPz5p8jSmhCVkD4xX1l8UfEkUg16bNWtql1
	 qolLPlf8eZJZdTzxqVygmHM6Xc0vsorwXbg29sU7iLH2fTfhTNSyfdTYfuQ8YySvCD
	 XF8ikcuR7f0IueSQCIjUH68sM+W1BLU0U5hlaiN3t6YixuVHUh9grjYBn1aIQfbuTd
	 e52K2gpaNQGYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BAEF8166E;
	Sat, 24 Oct 2026 10:13:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AB6843
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C14C8166C
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkIIkZaY-Wjr for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 729398166E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836779;
 b=ATHOhig10oioocEbC8hvnCWXfiV8yJ0gikmrtrpyKPq4A4eiQJnTGt0b4ARkgz24RL8A
 bYb2o4kbttA/811AWyVHRKqXcp4uATOawRhxKmftsywKSnQ3ee0mBe3SjpEHOKWK5EEtI
 qDyk0/Y9TdnFG+Cn+cOQSQavjCaIF59vxm05mpZCu1LrJ3PuEfI+jeA3IgRU5IRKb/hQv
 2jgKy7XAd5NksICBs2LGGe4AqgFzUYQa1Nrp4hBj6UJE+xx5uV3V3/V3jf0IDeo284LnF
 6g5FsQJynoKZVKSId43XmtPtZ40DF7SfaPAga3jlt2cekD7WIPUp5g5cim88DMVKqow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836779;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
 b=tZu/sspnFYKoTr/Ao4dw1x6KKVmL8sBWyBjfbyo6cGFQWcec9cAmNEiWO+MORw2azLOW
 euaofnfGqDg48z6LeOwEY+xIPQTscIgLEMRRGMN86oWrKosl1/NstbQSaiMnpXXGCmDkw
 uylCVi9UtNYmNTxAf9+FU/9R/LVZ3yiWki1vgfJc1h6h4bLsTxuOxSETbbS9RzoTBLI8D
 q2w9M6+6QKOidaCud7MT2jLXbchzo9gHZlKLXzMj5PgxQf4NpQMdLw2uiYpaGmK9JEot1
 71FeU4/XAqOjhVmenSCO9sKHd3IHeYbU8P1vjvlDNiDwnyRIcORQnW8viareM8R1QYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=L5GgPEda; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=L5GgPEda
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 729398166E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:59 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-844a8bf7e25so1175547a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836778; cv=none;
 d=google.com; s=arc-20260327;
 b=GIusQ/KWw3XbzdeWhd0lAVDOmIWiXSm4bQZuzcSmyOjEXq5AbPYnA/JhjWb4aQ3pdw
 MSU61C1ZKYoVMIcZktSnLFw7iqL0Qw9Mxoh127DPXtWAeFvimetDvA0W+Q5SmvbhVYqm
 /BctBgU5zjW2QJva/PaJZ/0wVehJwZn6brMeT94e5cY7e9oEBcNrI2IgJCRk5DwLT5t7
 HnHVUxpVqJUIym2kbJx2H3qN9mBLn/crOfOGdT6vu5WhTCe9Vt7OrRPqTnhQSWLA6p80
 S9OrAHjmtkoF4P7XSz8GNP0A0Y0gIMr3FM1lfQQtq6yP5ASspzHWkIdprrMS58ybBA66
 V4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=CBHKq2CeIONR6oHSOywBD/YwzrS7sbRpMDgAfWebs80C1bt7KAVMXvXRFo87Wgp84A
 z44B9gGhfcZF7jBOOeocb7SLkhtVyaWQNewZer7QmWbrSTaWpWGmWARBdgbnY94UxOu+
 e6U4FEjoUdS1ZDgFTOs8/GfcIwWQIAfNQ83m7Zq+g5G3022rWKd3QFQ3MBSrNuUTdt9j
 Mw0cdStQtsuTJKm1pzihHBbKO15HIz24kE8tS9DdJgiaYD+CuPfyRfvJXVnoqj9jMmko
 pBITPkDKNyo0Qp9E04TeN7C4wKmKPbSBiIQlxoXh1z9sfDmvpnqkmMFsRt7zIyFK21k+
 2Sww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836778; x=1793441578;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
 b=L5GgPEda9NbiZPK3tXRzsVnQrMkOj/SdMvCOjiDU3jBgCA9eC6SFfyoGyfrWipXE0x
 aFsQ7+L0qs6+B4wiR+tfIMzLGyOHrDDho/fahnuustBX348XX6oqxxXdghPUXX5RSeZ4
 4BAHorqhJwgH2oUg4BIzqpsnmh5TuBKcIFJaB73i2pCXWgp9bOo7mGr8S96D6Hp6x17o
 eUTL7f839QrjzbmEk7qxHSYwY8CBOnUUbP2lofyzrJ3d47cBtBAV5HxM7lbHF2Lpqf3/
 +JJd22ErOFPPlowDRxd1JOYG/mF0M50XUy8GfCuoHhYk4/UvxjOtnzRh28qrTOe4QRcz
 zVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836778; x=1793441578;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rrywfdzMqGFVyrQ5nGwKePHZBpSZBvfH+QQW71+c9OE=;
 b=DwbrIookqGh1Esvbq1I5iyGvoULCDLnwvqUNly2uRgJwzWqPAI6y7jx+28iGgDVNGL
 MrOkyevu7xDllGGGufX5admgrMVCa0pvJ4LvXIKlpPOG6g6hyCvuTVAtkGb9BSqkiQ+d
 fvXJgQqkgJwAjMVXM7h3cjxjLGU3lSRfqcvTGfib3PBBx9HeL25shprvEItksw6IVhla
 Nt/RBt/nlqQ0L7Sn+HImd8wvB8zd0B1Ei7R0kcFQkOl4pOT5MA6jYrKfGKjF/urHh8Ks
 wVqefO/ScPGLK8NK3q2Pdrk+S5AP4fEljALLrhnn/pMShkQpLEcorFyRR2eUIWzak/Cf
 5NWg==
X-Gm-Message-State: AFq9FYLHlxwUR7B1OvEW0zJaEFsNOy2nJKXNURMEJnATYBSODHKJD2od
 RQil4I4EtraBr5nAd1SxaB3fKi3S7OdJW8k1mrLEHF2H+/nMw2P9ClK31ui9jGvTacYe87xAVoF
 eD1snFbSv+1mjgydW1OoZnb5es6oATYtaReO3
X-Gm-Gg: AYBFou20rSnwfpFy9Fdklv5hVNV/mINXaH9sT6vnntHY/zKVx+ABVJALx/dkc/UvUAb
 H9remK02eEeaG4d74M1lSBD8IJY6lCZIcyUSFu68oxPWvHxB568czPxlDIXWdC72kYdd3KZyMNl
 E1dMv6PHKgfx8lZ21o7CRdsrjsNhdZMkyix/I6yDBzaknsc9HEUTQtg3mwSF5JmYmOVcbdKk44R
 lCCqKcEkN45A55fZF7BztB/ZbwUyNB8ysGyckG1O6cks2q30ZTq1NZR8l2TiEFlnViTBrnRHTZ5
 fyQDJ2/Ni1SAIT96p4pnyQfR9qBOXg0o886wiw7iQ3xSqfx1J1NTfutKfUxAKwnb+1QviFVFRyD
 oOr9vmvuk9uT9c1pQPIIyALPdOQAZOF2F1FyjKw==
X-Received: by 2002:a05:6808:199a:b0:4d6:93c3:1af4 with SMTP id
 5614622812f47-55c003bac76mr916993b6e.63.1792836777730; Sat, 24 Oct 2026
 03:12:57 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:57 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:57 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:57 -0700
X-Gm-Features: AclHuK9KR7XeyHhRo9SCCZEZjVEeBY0zB3pnBt0QO3lch00Z2oKDByrNbWEbCZU
Message-ID: <CAJnxHsirtt8C370AqXddQA7hVxrq-2qVtTuA3eBisWZgNb-YwA@mail.gmail.com>
Subject: [PATCH 5/9] nvme: Skip a namespace with an unsupported LBA data size
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000047031b065e935780"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000047031b065e935780
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000047031b065e935780
Content-Type: text/plain; charset="utf-8"; name="0005.patch"
Content-Disposition: attachment; filename="0005.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: a9c9bce0a43a2c9b_0.1

bnZtZV9ibGtfcHJvYmUoKSB0YWtlcyB0aGUgTEJBIGRhdGEgc2l6ZSAobG9nMiBvZiB0aGUgYmxv
Y2sgc2l6ZSkgb2YgdGhlCm5hbWVzcGFjZSdzIGN1cnJlbnQgTEJBIGZvcm1hdCBhcyB0aGUgZGV2
aWNlIHJlcG9ydHMgaXQsIGFuZCBzaGlmdHMgYnkKaXQ6IDEgPDwgbnMtPmxiYV9zaGlmdCBpcyB1
bmRlZmluZWQgZm9yIGEgdmFsdWUgb2YgMzEgb3IgbW9yZSwgYW5kCm52bWVfYmxrX3J3KCkgc2l6
ZXMgZWFjaCB0cmFuc2ZlciB3aXRoCjEgPDwgKGRldi0+bWF4X3RyYW5zZmVyX3NoaWZ0IC0gbnMt
PmxiYV9zaGlmdCksIGEgbmVnYXRpdmUgc2hpZnQgZm9yIGEKYmxvY2sgbGFyZ2VyIHRoYW4gdGhl
IG1heGltdW0gdHJhbnNmZXIgc2l6ZSBvZiB0aGUgY29udHJvbGxlci4KCkNoZWNrIGl0LCB0aHJv
dWdoIGEgbmV3IG52bWVfbGJhX3NoaWZ0KCksIGFnYWluc3QgdGhlIGJsb2NrIHNpemVzCmJsa192
YWxpZF9ibGtzeigpIGFjY2VwdHMgYW5kIHRoZSBtYXhpbXVtIHRyYW5zZmVyIHNpemUuIG52bWVf
aW5pdCgpCnNraXBzIGEgbmFtZXNwYWNlIHdpdGggYW4gdW5zdXBwb3J0ZWQgTEJBIGRhdGEgc2l6
ZSwgYXMgaXQgc2tpcHMgYW4KaW5hY3RpdmUgb25lLCByYXRoZXIgdGhhbiBjcmVhdGUgYSBibG9j
ayBkZXZpY2UgZm9yIGl0IHRoYXQgdGhlbiBmYWlscwp0byBwcm9iZSwgZmFpbGluZyBudm1lX2lu
aXQoKSBhbmQgbGVhdmluZyB0aGUgbmFtZXNwYWNlcyBpdCBoYXMgYWxyZWFkeQpwcm9iZWQgb24g
YSBjb250cm9sbGVyIHRoYXQgZmFpbGVkIHRvIHByb2JlLiBudm1lX2Jsa19wcm9iZSgpIGNoZWNr
cyB0aGUKdmFsdWUgaXQgdXNlcyBhZ2Fpbi4KClNpZ25lZC1vZmYtYnk6IEFuYSBCb2JpbGxvIDxh
bmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9udm1lL252bWUuYyB8IDMzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvbnZtZS5jIGIv
ZHJpdmVycy9udm1lL252bWUuYwppbmRleCBjODE1YTk2NzEzNy4uM2RmOWI1MzFiZmQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbnZtZS9udm1lLmMKKysrIGIvZHJpdmVycy9udm1lL252bWUuYwpAQCAt
MTUsNiArMTUsNyBAQAogI2luY2x1ZGUgPHRpbWUuaD4KICNpbmNsdWRlIDxkbS9kZXZpY2UtaW50
ZXJuYWwuaD4KICNpbmNsdWRlIDxsaW51eC9jb21wYXQuaD4KKyNpbmNsdWRlIDxsaW51eC9sb2cy
Lmg+CiAjaW5jbHVkZSAibnZtZS5oIgogCiAjZGVmaW5lIE5WTUVfUV9ERVBUSAkJMgpAQCAtNzAx
LDYgKzcwMiwyNiBAQCBpbnQgbnZtZV9zY2FuX25hbWVzcGFjZSh2b2lkKQogCXJldHVybiAwOwog
fQogCisvKioKKyAqIG52bWVfbGJhX3NoaWZ0KCkgLSBHZXQgdGhlIExCQSBkYXRhIHNpemUgb2Yg
YSBuYW1lc3BhY2UKKyAqCisgKiBAZGV2OiBOVk1lIGNvbnRyb2xsZXIKKyAqIEBpZDogSWRlbnRp
ZnkgTmFtZXNwYWNlIGRhdGEgb2YgdGhlIG5hbWVzcGFjZQorICogUmV0dXJuOiBsb2cyIG9mIGl0
cyBibG9jayBzaXplLCBvciAtRUlOVkFMIGlmIHRoYXQgc2l6ZSBpcyBub3Qgc3VwcG9ydGVkCisg
Ki8KK3N0YXRpYyBpbnQgbnZtZV9sYmFfc2hpZnQoc3RydWN0IG52bWVfZGV2ICpkZXYsIHN0cnVj
dCBudm1lX2lkX25zICppZCkKK3sKKwl1OCBkcyA9IGlkLT5sYmFmW2lkLT5mbGJhcyAmIE5WTUVf
TlNfRkxCQVNfTEJBX01BU0tdLmRzOworCisJaWYgKGRzIDwgaWxvZzIoREVGQVVMVF9CTEtTWikg
fHwgZHMgPiBpbG9nMihCTEtfTUFYX0JMS1NaKSB8fAorCSAgICBkcyA+IGRldi0+bWF4X3RyYW5z
ZmVyX3NoaWZ0KSB7CisJCWxvZ19lcnIoIlVuc3VwcG9ydGVkIExCQSBkYXRhIHNpemUgMl4lZFxu
IiwgZHMpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CisKKwlyZXR1cm4gZHM7Cit9CisKIHN0YXRp
YyBpbnQgbnZtZV9ibGtfcHJvYmUoc3RydWN0IHVkZXZpY2UgKnVkZXYpCiB7CiAJc3RydWN0IG52
bWVfZGV2ICpuZGV2ID0gZGV2X2dldF9wcml2KHVkZXYtPnBhcmVudCk7CkBAIC03MDgsNiArNzI5
LDcgQEAgc3RhdGljIGludCBudm1lX2Jsa19wcm9iZShzdHJ1Y3QgdWRldmljZSAqdWRldikKIAlz
dHJ1Y3QgbnZtZV9ucyAqbnMgPSBkZXZfZ2V0X3ByaXYodWRldik7CiAJdTggZmxiYXM7CiAJc3Ry
dWN0IG52bWVfaWRfbnMgKmlkOworCWludCByZXQ7CiAKIAlpZCA9IG1lbWFsaWduKG5kZXYtPnBh
Z2Vfc2l6ZSwgc2l6ZW9mKHN0cnVjdCBudm1lX2lkX25zKSk7CiAJaWYgKCFpZCkKQEAgLTcyNCw3
ICs3NDYsMTIgQEAgc3RhdGljIGludCBudm1lX2Jsa19wcm9iZShzdHJ1Y3QgdWRldmljZSAqdWRl
dikKIAltZW1jcHkoJm5zLT5ldWk2NCwgJmlkLT5ldWk2NCwgc2l6ZW9mKGlkLT5ldWk2NCkpOwog
CWZsYmFzID0gaWQtPmZsYmFzICYgTlZNRV9OU19GTEJBU19MQkFfTUFTSzsKIAlucy0+ZmxiYXMg
PSBmbGJhczsKLQlucy0+bGJhX3NoaWZ0ID0gaWQtPmxiYWZbZmxiYXNdLmRzOworCXJldCA9IG52
bWVfbGJhX3NoaWZ0KG5kZXYsIGlkKTsKKwlpZiAocmV0IDwgMCkgeworCQlmcmVlKGlkKTsKKwkJ
cmV0dXJuIHJldDsKKwl9CisJbnMtPmxiYV9zaGlmdCA9IHJldDsKIAlsaXN0X2FkZCgmbnMtPmxp
c3QsICZuZGV2LT5uYW1lc3BhY2VzKTsKIAogCWRlc2MtPmxiYSA9IGxlNjRfdG9fY3B1KGlkLT5u
c3plKTsKQEAgLTg5OSw2ICs5MjYsMTAgQEAgaW50IG52bWVfaW5pdChzdHJ1Y3QgdWRldmljZSAq
dWRldikKIAkJaWYgKCFpZC0+bnN6ZSkKIAkJCWNvbnRpbnVlOwogCisJCS8qIHNraXAgYSBuYW1l
c3BhY2Ugd2hvc2UgYmxvY2sgc2l6ZSBpcyBub3Qgc3VwcG9ydGVkICovCisJCWlmIChudm1lX2xi
YV9zaGlmdChuZGV2LCBpZCkgPCAwKQorCQkJY29udGludWU7CisKIAkJLyoKIAkJICogRW5jb2Rl
IHRoZSBuYW1lc3BhY2UgaWQgdG8gdGhlIGRldmljZSBuYW1lIHNvIHRoYXQKIAkJICogd2UgY2Fu
IGV4dHJhY3QgaXQgd2hlbiBkb2luZyB0aGUgcHJvYmUuCg==
--00000000000047031b065e935780--
