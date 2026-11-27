Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FB606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K19/kPmZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NLxIykQ3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD6BE81299;
	Fri, 27 Nov 2026 16:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1o6o8JDt7CO; Fri, 27 Nov 2026 16:29:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A83281215
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795796975;
	b=bRUNyhT2IDGM0DbQzmHqpW+v59jDADCs8MXifL4G+7beS2pERuFYqzygheFM7WGAX4do
	 Jgyh175+AxXbUZ6G60TlytfehpEMj2EBEGiKzgedFTWJbhvz1vUlwLkPBQl97b/2fiPCn
	 zuoQ3ybcZmPsOCa4T26O36bERUlcAfUzoUmR1QfBKRw3m2hCn0f+sJs8Kb5LnS16ails5
	 +h+EjSMVoNFPiaT6kSPj2Gmrb7eBDv0a+aTLSs5EWu2fwWhFLhIBLJpfqnPmFpsbVlfXd
	 0iA0MIYdjisApTRNjZqMnzsCH8DCtdD+I8HaT7HhUMn+dgu150G6hAm9pRjT8pDbRAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795796975;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jMol9FuiJkwAc8+0lVxslKRJpuXRgsgxfYxaI9k2UB8=;
	b=Ksh9u0GAot15hFrBpShnQIuPuCQeme7QedOPYitAoLCmybIjhHuNzFl2YoRy+DCVK3Vp
	 6rvuWMiwXzxp4O8GDK6ETNcgHjaKso8KQZeayEVKowT24er8pvug33qbuHrOyrsEDQ8aV
	 2mFVrLbbKhV78pFtIRytcLKxn7ZndEZPBK4bpFxqCOt+j8/8EmZK6NAjDU6FSlOrgDoZb
	 qWWLhBBEO/3ENmumKu4VLF6fTyV9WpJG4GVpXIRzfohqJxOtd54ZBHGfHYGm2EhCcX/7D
	 VGf0KInU8Ro5ifkQwG06vjA0Aj2E8VsI/+nW9uf1RJQmkXtCUPF8D27zAXsQXiCh+Vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795796975;
	bh=jMol9FuiJkwAc8+0lVxslKRJpuXRgsgxfYxaI9k2UB8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K19/kPmZE7Aee6od05NJLbpfLHIugjgbYJwQvWVHwajwDQoYi53DNoPPmU80b4dAM
	 BW2h/utEzjhetvhla0TEC+6hCvzMTTqLjehtHmHPHB/xFhJFNcZAS8FI+8Kdzs20G+
	 9Y2QInHaZHYZA0QfP2ekQWI1kg+RGl5fLaQ+SthStOvrVvmU3O4x5pDAT8jWWmUKjf
	 AGkbGi3sg70033CQYcKcUMnBZ0jWQ3flj7mEBrobk/c0m6/yYrxN33UzPDJgD2jSnW
	 a324jnlC4et4NO2ySAASNGwiDEg4yCzwU5t+yj/LIfxSudMhlOSmO7PY4RnJDPun8W
	 eOZ3Ajh85mqOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A83281215;
	Fri, 27 Nov 2026 16:29:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1863311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93B2C60748
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2uhbjEQrk7E for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 16:29:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D302F6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NLxIykQ3
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D302F6061C
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 16:29:32 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-71ac798b8bbso5012412eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795796971; x=1796401771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jMol9FuiJkwAc8+0lVxslKRJpuXRgsgxfYxaI9k2UB8=;
 b=NLxIykQ3zcZRevVLRGyAtDqjORD7wYE8udwhtei2ejQhRonU2UtgBdgd6Wc+vReR62
 DBPWvDfehdNFzndnubGSR/Nw+zWqYsxrQ5X5ZcRJD/DpuhkTTq7gkNRLM0VDjh/QRCK0
 /8d+QTmE8HVmUxSHBll4vUzG3ZKLunHTBdEcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795796971; x=1796401771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jMol9FuiJkwAc8+0lVxslKRJpuXRgsgxfYxaI9k2UB8=;
 b=ZusbyGe8v1BDK9lQqs4YC9pUFnuzCa9vhglK8noHSgfq9x0MHOZrAivRQta+Nsjcmw
 R5Jl0aWHCTdwQuyjy57t40OfEenLLmLDhDUroHRBeWeOFyhnrENbaOea7UjnS7M0lYaW
 ZICdesu41IO7I8WkxDhfpG4ZRJlB8dLQZNwmqPanE7fa3+C+0gY4ycummFbURRmDq3Iu
 s7b0RzeqAYvdS2hP9l/KMrgxh60tz6kk0XbxqQHr6HmdIin1UsGYxxHeTS5qYPYydnhj
 8TbFewWjqpaff3DIHhHVbW15uaU6pkGASncH/cIqBFqUfQ0f6PUj15VPdG227JrrqcOJ
 Qnsg==
X-Gm-Message-State: APuU4Z8vgLpCiU1rtMeXKSxMl5F/NW6Svu2XrzBWoiE4OJTBD8yVKK53
 jZ5HS1CHnpk7sjbUnGpatqcWMUoxCaATXc7Ot+gapsQem30i7NQ5S6/3556kmT0sQmcjthKSgol
 Hxthis1av/ZL7
X-Gm-Gg: AZFdTZcT1qohvYysIgu3CycAwLWiO5bH2wIJ1TWv7ejzHXaO8iR6qcXiE0LJ/R2BtxN
 hwiRZi5DTdn4I5lHIkfwlOPym3tEzJI0646YVYN/6EkDpblpGrLH0uLYmxVtLKeM+8qdXlbQayu
 tG6Mdq3ROSH6N4pT3pW9Hycm+QkQXvCQdDv6xTnYe55evKYZRZ9eU4sfTbnW9AD8Lcq0k/w+kFO
 MDAJFyistB7P3GvKhyUKkMWGuhtvXML2xUql1ixdvnnLN/Q3mZ8mtBZbyadpSf1aGnmKR0ld4/B
 oxpNSQ3NKZURLv3dm5qC/10Ri5+mpFYK04Jrk2PzSTKlJP5nohMez+DWaUg3QBkzV+B/O+l+eSW
 GeFpuez1V4yMMeTDfxjC1bSbOi7bPh8QACbxHdnhehsI+qbTlQE5M7ARp4xh3Re6uow/XSBtOl5
 fqxaxjZTKHbX0hKTqYj1FQAGgUCD/f8sIy7uOuVE7Ew8CSgQsWWc35VvaQWoPx6xOIvaEPy9wXh
 B+2XluDuMG7Rg1ia5FK73WjkXIBUCGD+tlW9J3PK02oX+p2apXsx7U2haXBrahaVj5fg4eQKb9s
 Tbaf8jvIPlHgeR4fO5u/s9mvCUemfgETr4/SRmLHAGB6DwKG7L8gGoSu68Ql54K3HFMPPqNK6OV
 qy9kdfmtl3YApWw2SOwow5gVLKPj8QaACmpFTmuwmq8A8vG7On9NKLTeSCyWazPFqqdj4dMHaXe
 A++jMNqlrjDYgj7BFZzmPA/mtDKscs1Lxjgruuav0nKohcF3Sy8JTgOgF/
X-Received: by 2002:a05:6820:a751:20b0:715:2424:b6c7 with SMTP id
 006d021491bc7-71b392aab38mr14582522eaf.2.1795796971458; 
 Fri, 27 Nov 2026 08:29:31 -0800 (PST)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b865900ccsm4746056eaf.6.2026.11.27.08.29.30
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 08:29:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/4] Dockerfile: Minor robustness updates
Date: Fri, 27 Nov 2026 10:26:25 -0600
Message-ID: <20261127162927.3545062-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125134317.2479815-1-trini@konsulko.com>
References: <20261125134317.2479815-1-trini@konsulko.com>
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey all,

As part of rebuilding our containers for CI again, I found two types of
problems we need to solve, to make building them more robust. First, it
is possible that our toolchain downloads from kernel.org mirrors can
fail and we weren't catching that. Switch to setting our SHELL to bash
and set pipefail so that any of these class of errors will be caught,
and for kernel.org specifically add retries.  Second, we should be
cloning only exactly what we need when building qemu and grub as they
are big repositories and doing a full clone and checkout is both
wasteful and can timeout. A future cleanup would be to switch these to
building via tarball instead (and any future cherry-pick fixes can be
downloaded and piped in).

Changes in v2:
- Set SHELL to set pipefail so we globally catch that problem and don't
  touch mkbootimg since we should just not download that.
- Reword the cover letter to reflect the above.

-- 
Tom

