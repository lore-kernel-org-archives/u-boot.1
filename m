Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B193FD49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371658946A;
	Mon, 18 Nov 2024 15:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XmO+8mU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94C9890D0; Mon, 18 Nov 2024 15:19:43 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1704489474
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460ace055d8so24747551cf.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939580; x=1732544380; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zf9cjCpK3uagkK9amYIgCn9+koNUSvykzzqU2saSK4=;
 b=XmO+8mU1pZCXR3IF1GCBHBL8Q8o0fxy6/IQ5wYNWM5Ync3viKnGoxv7QscdBjTF3li
 L9cs/5J/VckFW2dwqYBs6HgZ+J4j0t9MthKKXJKg0rJu/q/iJJP6im1W/m8DIU5EMuZ/
 96crNkvVYwnO8piBDNkptrDt8AEyvxROkBsjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939580; x=1732544380;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zf9cjCpK3uagkK9amYIgCn9+koNUSvykzzqU2saSK4=;
 b=UWVYJZakQ///ZVlXMESlJs78R1f7r5qquVzbxMTCOD9PcOfL5bb2QD4E2cbBzSCFWi
 lkGNO/89eZeGCv3P/qlteP98W1vnAwFVDvrwkSg5qxXx/nfr1dSQkvPbLsjw4grqDCQa
 HT4aLjR4bb36mYOTq5yMe3rlEt51JX18fzl/a6hr8sVpak2UaR5krg+VM2L+BtPyo2CE
 DtylpmVA7uKto3kGPwCxQ/ITrKT32fZcsmx1rRXYdpmwna8NIp6AFTMFxN2vUE7hJhPC
 UYqkOH8wGSc+rMUV2RUsoZghYKUn6SQZAEtXl9NyNdQglSjhkvdxNpjPsrPgdBNLWj+a
 vV9A==
X-Gm-Message-State: AOJu0Yyk5uliDK3qJ4C7VHevAZ4+z1frbw75qYAXJMS88CypEo+zCVQ7
 WlLAE9izOqIqkO2sYPZZfkudt1KPQ03YFm7+10PfDcFe++8p7hgkilN/U8i68is=
X-Google-Smtp-Source: AGHT+IEXvjyM5xwEvgJIkV2DdH7BIeAofYGIKxRZ3+DAx4/jmYO7hI9BtBXS3VQskjWdrgbdQUd1OA==
X-Received: by 2002:a05:622a:5b9b:b0:462:af30:47d with SMTP id
 d75a77b69052e-46363b6b7b2mr140235491cf.0.1731939579983; 
 Mon, 18 Nov 2024 06:19:39 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <0581a1274f4aefadd5a3df8c503cd59f4f8935a2.1730797446.git.love.kumar@amd.com>
References: <0581a1274f4aefadd5a3df8c503cd59f4f8935a2.1730797446.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: usb: Distinguish b/w ext2/ext4 partitions
Message-Id: <173193957906.3366111.10147894503102205738.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 12 Nov 2024 14:27:38 +0530, Love Kumar wrote:

> 'usb part' command shows the partition maps and shows the partition type
> by displaying number such as 0c, 83 etc. Observed that ext2 and ext4
> partitions shows the same number, i.e, 83, so, using the fstype command
> to distiniguish between ext2 and ext4 partitions.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


