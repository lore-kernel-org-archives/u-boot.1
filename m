Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D59CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6822283B91;
	Tue, 11 Nov 2025 21:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wolh4mVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E87A83BAD; Tue, 11 Nov 2025 21:32:58 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B8383B8C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:32:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45038ffac4fso46712b6e.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762893171; x=1763497971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hw4GkNEkCmQny6Y8CDypDvlEe5f9zT4iB2wfRN/pB9o=;
 b=Wolh4mVENPKKMZSDusjk0a6c3cqCPHga3oP08i6PpWOJNN4C88DaY7Rfkuk7kPNQxQ
 N0JEfj52AD3bp1+GXoSj7USQSbPIG+xT9WaWRyBVOh1U8BTKpQqr8OhUMtvsUD6COSAE
 nAdOuMrcAazgx8EWw40yVjjr6nqedigk7SaqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762893171; x=1763497971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hw4GkNEkCmQny6Y8CDypDvlEe5f9zT4iB2wfRN/pB9o=;
 b=gVISFGcDwLdEkPUzTQCx5//UUrT92MZxqWysUE6Tllz25wCla9ytAnYkLtFNIp0Ule
 tpLLw5mzH+ayEhbwa2dPrtnbk1a9SfpB5qXkjARkk6qyZzSAtlxjnGoxfu/c4Wc+vjbq
 DJzN1+Y8QBQv7fnR9rZuz9JP+Bofoxovxk7zsUjBqhHWNHyZ9F63Ozu7fvx6Bmyic/+7
 wG7IyNJlOnU5RFd0mQBeqcvqOh8chvh8p4JBNg9GTu0EqjJ20ncbmoAz1shJhgfV2Ygd
 iHzq2tRU+wBfR6FyerLfWUz2NcTISuA8Xv/iy2RiTykPBMPymhscjHH3qzhVBOGqYe2A
 waLA==
X-Gm-Message-State: AOJu0YzGJuQhAJDa5mXWiqHYhXfUSqZe83sJQ6Z9EDjA90f8tI4tbJET
 jFWMs4oeQr4D2EIFKC/PxnhyRN2axS+LX1T/ZPJI3oWXa4TjoJ8T59v/Zt2xY/3XoCTPAwfbwvD
 zyAIDBQftdA==
X-Gm-Gg: ASbGncszfid+mpUvc5c75HBnJGMxHBCRPmCUFRZZciz0lOneHlCuhx5YH25oWbWXMTT
 qJX0FBnscHyW/UNZSH9ZK549alApi748cg16BdTfzkBn4YlspdC+ioiQhg9rpGbs1NOFqVWGZMw
 qYF8Nhz2BilkMzrKTbwWdz8QviWm1sXhq0w/Xi46lxNuh32w62TJg5qpXNoAmFQ+D0CdmLFjlt3
 fu2syNnUC7AHsKDfzeObxM7fDyKVCedibDRYgkahS416EUS505Lr+r1H430kfmm1PWGyDmFKmZT
 Fguj4IJDGDjR999L9/DYjuLerjKA8dcmOYw8W+quRCWnd/DorIWFzK5WMZk71TcUd8OhDTBTPLG
 9/TchoAKb6YUJFIH5s3WEEayn43MwC/jfo8UOktPw3g1znqfSugLyWkLLiSi7669GCX8YnGe7DP
 hYMQMuSseb2nDRUsTDvukgtzrP1dIbYTq1PNZxzXOa8aD4PZHF1CCo
X-Google-Smtp-Source: AGHT+IFZNaeUcgy9gpWrfpzXP1bXmEsveRhL9jV1bCuhH7tgm7CWtB/us4aTfzQpY9n+dudo3Oedfw==
X-Received: by 2002:a05:6808:c2fb:b0:450:2854:405a with SMTP id
 5614622812f47-45074654e1fmr241848b6e.45.1762893171430; 
 Tue, 11 Nov 2025 12:32:51 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500257fbadsm7372863b6e.8.2025.11.11.12.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:32:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Prefix more of the sjg lab with "sjg"
Date: Tue, 11 Nov 2025 14:32:49 -0600
Message-ID: <176289308244.740364.6319163050364048294.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106232833.3243530-1-trini@konsulko.com>
References: <20251106232833.3243530-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 06 Nov 2025 17:28:32 -0600, Tom Rini wrote:

> In preparation for adding more labs to CI, prefix more of the sjg lab
> components with "sjg".
> 
> 

To make continued frequent testing / use of the sage lab easier (this patch has
the only context change the sage lab patch depends on), I've applied this to
u-boot/next now as well.

[1/1] Gitlab: Prefix more of the sjg lab with "sjg"
      commit: 4b46f98244273df9fc7472a99a5678511fd5870e
-- 
Tom

