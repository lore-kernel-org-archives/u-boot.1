Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yvUUCAsi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BnChPpOe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE492607E4;
	Wed, 21 Oct 2026 12:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i6CLZ03elovl; Wed, 21 Oct 2026 12:21:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8FD0B60773
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792585301;
	b=QZpae04mytzOz0oKMqJuFe+LPmCFEiP9DM2UNVqZbxEV/D4s7X8ae/oKHwJFOhXxBNMi
	 AJKtQ0ph7FWzivVXosDU2rUo8VTrVuE4+TYQDUPwURJ4fokY8pkzVTjcas60M9UjLJnVi
	 p++fBNDQcWfvSQt4NHFJ/fvDGibaqPx+NFLHCXLl5UGoZRkOPt8IdexYQRkZSBtGW2r4S
	 GV2szWG8Zik6T3vTOOP8zBhtWz/95G7u12p0Ob5vf7IzwCeYcZGTwFbqaKEAD32MhFDrp
	 KkZZMGnWvmu0od0qS+B9dw+qMaSl1g86FZw6pUJztVsyWm5uJke113jVxoDWcj1QZIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792585301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HlGhS1APdrHtyUK2zDmWcg+PBr8/JGkOFKgOdpGcOZ8=;
	b=mRzj4XRsb0lnD2u7Kx9V5Y8pl23G3aq+0UMhE//0U5PcoY923nhLyypkrtSS5nXC7mIH
	 Z8ILes+o4lKRCAZwSzcBUj+hfjP97QU2BBcx/7FoGHGNtmQegjSH9EBNOtzeGxp3G849t
	 4pe7m8SHzpwUDqa2+m2S23rtFGEAzo0alTKKJRnc7hSJeaNw6aZn3VvBFZqAjL6+wHeSz
	 VUWYTZl6l7BBNlHk3HXJh58HmmRvaN/kjvP3pr/XiiczmGmNwvqa4aFKXJDR3pscc0/gL
	 qN32gYHvdb9Ydihkt6BB9RgX86Aa03KrgxuR4c+UPO3AB6ZV/oWx697DOLGIFvS0rXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792585301;
	bh=HlGhS1APdrHtyUK2zDmWcg+PBr8/JGkOFKgOdpGcOZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yvUUCAsiBxcbP+HNCDOlit8brP5AEhGCSQHCtd3Q7pUg1nN+G2zGaPvOg7g2cGIIt
	 TSO0U08Jspu7CYGRoUO3m+WTlLJJA8p7wCr1slwIoyJZCe8dnSOWzPaimHOILx/gPm
	 DLfZUq7yvWpWTbGWvxIs8nqYWCBPmiTYmpnWuOXFBJmZMzjSQmPcgQdVInuS6GiVs8
	 iydIUh0LfrPp+Oxd9ULXYHmHW46dnzu31wiZbgFJhMW8PJMN6lWAwKxHX9UwGpipBa
	 Qjy8rpZjpN+6bDn4L90rzUxwT2EPFeJl5f44QoTSpadg/O7vbePVRCoS0ku0vZ3YNk
	 1RfXgnUTnR1JA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FD0B60773;
	Wed, 21 Oct 2026 12:21:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DD3E1E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3C614076D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQTU3QUUV4-C for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:21:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 239D940769
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792585299;
 b=cV0N2qJ3gRuaXyWjtQM5MWj6iVtpWySx9KoHASB3pSXjRSioZiNIci/lLmRK4OdoUDxf
 6JaJf05bTFHW+mJj126XXpanmugRnIeGTTXBImkK9Kg4j4+qcex4Yozr5KtDP/OS6fW8+
 VMlPWGlkokR8QjyLHHZncADQ0ykptP+HCKjS2CwQNeOY5drtsMOH4XLgxzIkDyfl7vAR4
 pwDsvzFYKEj7w+teT3NIkZgyo2h5NJ/Q8evFIb2xEvINVRHq/w9T3UUKXMPjakE6GpWni
 wDvWA6NhgdMjdL/I67tsFFOmDw4WLOIJPqi9RyGl3/EFve4pPuMDbi7bltmOG82L3wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792585299;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=HlGhS1APdrHtyUK2zDmWcg+PBr8/JGkOFKgOdpGcOZ8=;
 b=eK8z329QmRyV2FhZ8MDY91mf4TWEZRwRhMbQkDUw7+oe6SCKIcsDEIC4atVHlNtU3Rw7
 3m6B20npOyoDwnl+5Hi+F7qiwbZqDEDKpDkdYCfLriu/yndNu6fUfT1P6kyT2owbtrD+G
 RoPT0eBPnJi/zRpdgYqhkpyyorYHzgFT9jrqj/vKwD1ROEimSKA3NfJbqBz88VU0snox+
 iv4zRiLSzueMysNvc2qld/YXq78rp4XBb5pec5vCAWv+216F5/Lt/3GOaHRqgML3H2hz3
 gkdI2VNu6pOkUKdY3S96C2dGtbVwmy/FLRIYjR/zRLaALujVFfkwT7gVzCVrEYBAnIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BnChPpOe; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BnChPpOe
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 239D940769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:21:38 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so5231655e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792585296; x=1793190096;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlGhS1APdrHtyUK2zDmWcg+PBr8/JGkOFKgOdpGcOZ8=;
 b=BnChPpOejxW+MGNZeU7LBdqep5FUZpukjXt+HY2abAe5a+cAWC3NxKWA/8XUtMuyZG
 VebCNviH+yIL0ZcLRyzTXfnSX9yWaPZXpRpHe1F/1Pc2iW18KlK6nr8tyPp3Yb9eCBIj
 KnE3nKHKa2hpPO72B42vVnza6+MqGM/x3mZAKpbVhpZX2e6wf2BYKUKtNulrbqtEn7G9
 QT7ZTfKKYn0e5aOas5/k1stlmq3CtMwYvyYdFjTkzObVaY+eCbRCusc4267LZ8x9zQlv
 9p0uv15DdhiAiZjBk2UrBZNzTfN59wv2IFRnEeZcNdxmB41/2BeRJqeYIcb0ctFan9IC
 2USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792585296; x=1793190096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlGhS1APdrHtyUK2zDmWcg+PBr8/JGkOFKgOdpGcOZ8=;
 b=gh0eP0T9HyFE7naWCYZwV3b/qFqu6pWJCjPDm7Rs7UhyQwoCBfPuwAhzt8jI3TFgrH
 XoojPf+d/nTDXs/cRPDbMu51/8Hq/mIL6fB2o5iuutQoA646e60KhnACZwZZ+0BOcUXD
 8wIw8Cu84XKQlvA1kyFRN+NcgcGIL4J8ABNGlD2dJqqMyUVMAQ9cYGOpnlMy4nxz1F52
 3yEGSXW5lFsB16VEjPF8ggZ2fOBiVCgPDDvh9BobfxWISWI8O4HOvkJa8qlyVLyFe7fc
 WqrH08U0jR4Aq3V9V36wmxd1h/aPiUTZdpLQ9DAUbvFjHcyX32xQw4TMfkUP/JRx1H66
 IJNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrRJzJlRw8tao8XyYRi2AnD4SR0HvxxSjlF3qRmZO4fXNf3luYlAveycwz6dqK8qTX+2bY3F4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWU7xeHCL5I3jzS5N9u7yS8OIgtFCZ/98CNVmAIYq4gs2WmYu9
 Gw8l8M4ZNG4FvWIIHiWTAWzyFiM/9eklAeSCTrVwKa3NE97byR5gvtPk
X-Gm-Gg: AYBFou0UvoMQww2xsADxJSjnf6cZLcWQ8aufYP2gELwNHqt+p7zRjZCgcHtuhSbijn9
 chJ7VcnOYuznuPrMx5qTpWfnlIwOg0/xtk3+CLe13H72jy0WicOJlxJBP4GfzkUHjxeDq8zRulx
 LJPmDSPcfj/PjrCZoGfOfReyZsJtt6EfLkReJcjuTbc1IeJ7AmuTQzWAyZ6RFRls9vvDG6P6chF
 C1b92/V7Yeh5Qpq+lHn1KDDi76AOfL7svzAyYEqDnn7iAV+OQVfOQc87Al21S++0NbgZWOSjTBx
 jfBZrbEpSDRSXGO3kkNfPMBepEtZL8HjKrqUODdFkkXSaO4179YLzILLmlnJ+0q4yj7vbfQX1zu
 eb7+GM5LX1ide2sG4vaZge1wGOBwVtsAFKE/9C6obQD8CRvxYvVwaQluGryxVS0yR43lpW7Y0np
 TFSU4wGjpJt/5QiFJ8pNY9I5yXkdMid1/haG1pfjU01D/rAQNNtwalGYt1XNfcNfdQA4p8DYub4
 2TLYfUBBuKxoO+G/JK8Wbh85EQAQ4V5lplgJODUqQIvYJTW5qObk1KGE7739w==
X-Received: by 2002:a05:600c:1394:b0:4a1:f714:3f3 with SMTP id
 5b1f17b1804b1-4a1fdd41954mr40026575e9.30.1792585296149; 
 Wed, 21 Oct 2026 05:21:36 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a200f4d16bsm15264485e9.2.2026.10.21.05.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:21:35 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
Date: Wed, 21 Oct 2026 14:21:34 +0200
Message-ID: <20261021122134.4139945-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <477ecb2a-3738-44ce-a563-4b029f5e6d39@mailbox.org>
References: 
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-21, Marek Vasut wrote:
> You probably don't need the ofnode_read_string(...) above, it is part of
> the usb_get_dr_mode(dev_ofnode(dev)) already.

Then a missing dr_mode fails the probe like an unknown one, where the
old code took it as host. Both USB nodes in vfxxx.dtsi set dr_mode, so
no in-tree board changes. Fine with you for v8?

Thanks,
Mehmet
