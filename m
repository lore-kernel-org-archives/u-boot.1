Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418B606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F4eVCo9w;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aUYo0jr3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD4840497;
	Thu, 26 Nov 2026 07:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXygG535ODcd; Thu, 26 Nov 2026 07:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F12D4084E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795676845;
	b=RBvxNdYw6rkxp4/Klx8H6usphmKzuTEIlLanXWP4LuqVK2D8zCC4WfoAJTpN7noeHHA+
	 XS6L0zl0rc3IuwNrytooGvNmarB9y00wNPwWIDTrf/k/kpTwH5SmYOXCr7SlFMUSPmfUj
	 37oywlhmic9Zv8mtCBDEj4ikYnExShqSs8naL9THKMUAoRBoPbfnjbGo9snYCDSCBDM8x
	 9AxpUIgAEYaN58IlljvNZOnE4ApqbDJc7j29UTxXmTHNd5Q7Hi6WFlqAHwg0KrIm1PKwz
	 UGETlSBmMGlIll3CQjvqwzTjAmpmODRapZms4oyZ2DnrA/IzQ1ZKFpFab7ipRsOOCqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795676845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dm8M1gPGnt6N8ktX7HnvCDlvJu+KsGra5hBcWXOFIDE=;
	b=cD8mChF77MW7c8wo1iXX5jMGCkOVbyMawUSB3667qI9iqkEOClSE5vD/TolobyFcaONX
	 8+vDO2FnTcCHdJ3O7ucAbRKuKdzSqzE+sdfuHqAH6OCgxogMZRf3gAQM1F1EbYYXXUhB+
	 QNAtj73uOkmtfezocwMt855vfTqs85jjSjwV5U9DCNU0affArWZOCKl/NI4jOv358mTyP
	 m5cZdtj9xrUbfy7EDmYMKemD0jxhwmGGL3581Tr2QVu06iY2NIWqNSb+G3OLfTDADGrot
	 KvRJnz4a0IqUA4CVxc0ArOsz+fj0mCumEO3oEZSPxgV5ReOCKmttVSdC8c0jNq/Ff7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795676845;
	bh=dm8M1gPGnt6N8ktX7HnvCDlvJu+KsGra5hBcWXOFIDE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F4eVCo9wC/mmIACx/3+yhJFv6kt4APl04AVhTiRwCoddYY9XlyLykkOxHG/vLMav0
	 q0LLCQQfbP/G0OBGxOq8xR4k3X2ewFT5lZY515dleKIvuapETXw2cX6RoeY9rWg6oo
	 STaVwS/LVwmZy0IeuMaSGN0/Hnla8IyIlSt2KYv0W+Kw92bBKqjQhDQuzwzJnHQKKk
	 l+s1/qfpj7Edx9OY4ghe443qgxYdEpatKTRuyf6zJyV9IuwPWfU+VxTPVsIHn0eZnl
	 dRs7x/OlO3Ygt4ky3a6xEg34ObaeEGWHmTZlTa3qYAeeUpnYZQNeCulIgffIPY4W28
	 y3rrd9yDjuY5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F12D4084E;
	Thu, 26 Nov 2026 07:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ACEE1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4839381004
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FJc8XV25pvj for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65E4E80A54
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aUYo0jr3
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65E4E80A54
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:07:21 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso81742515e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795676840; x=1796281640;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dm8M1gPGnt6N8ktX7HnvCDlvJu+KsGra5hBcWXOFIDE=;
 b=aUYo0jr3QnpIoL+Ma8c6pdRHy7uawdIyI+f1tXLSy1gn82U9Ysf8c0ZVljSNI5R8R9
 EIU+tsFbJ9EE87N/9uZDaypvWDgke+PzlBeJy0NZK7gYnfAJ7CQk++6FFbTE38XB2Srs
 sMtett1YQhX3TfcdxcmHrCNsTydzXLfOS5CPmadTGZyKyzn8gnmGZ54v/xsFIpRe7lnz
 Srg5FavkQ9wGlAf8lgI18a2ffT9oo+yDb6wcvJxDOYy/6fh3PwXDny9L+fuXiLMUxR9e
 zWXK1aXNnBiLyFIOqO6B3RG14bxJxePs6RVnfh78xnhIrCCtCKMwC5p+PGushO51SCsN
 Qebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676840; x=1796281640;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dm8M1gPGnt6N8ktX7HnvCDlvJu+KsGra5hBcWXOFIDE=;
 b=vJ8lcJ7VXvPpBM97Ma7QYkhUyUU01Oa9doA5a5vXPSWGckl87oCUxDqeQJZLCGgr0A
 HJHkKdtz7vCuBt/XDz67+o7RmFKAlpEF//m94gSwUkAk5mSuVUMmyq4E13NMhU2MN6vh
 tVrZVV8vmo0+YmvKTesiH39hstptANcMZ4GK04gCdaoPedZ+ck413TKjmwYO2pz2Lzkl
 UbmNWFLweLEC4YZVi5L066fXcd7JyO9YBeQyVm4y5MHl9qccyE2eEajJTECyCH+ruxxg
 168PuOg6bUKg+7xIwxS56iskO9LBAlQgnaQwxgdALCCqG/bo4xaMWIFsxl1mmizhYQZ2
 8nMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGSnNh2iOJT9Vq2wcslO7GNU9G6ezJ/9Cb6SLarGnIXXusyX062+U8fXt8yUONsu28q3vtvYjA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z88bvrelHUIgpo2mXlSDy4aqaorEey5nUhBuHeazvjVAmED2M48
 5ojIpqX7/kPsriptiNw6c1l3nnUUpTtFnUpGqbC5ydnkYGB63jgszPX3ewLAAd9FhtA=
X-Gm-Gg: AZFdTZdfyL/CextMuHenLgG7xvrmFgFtTMMKEzCD3KVcdrvADlBOE40QBQXA4clcYhv
 Jjxj3CZf3JJnNv9BCAiB92W8lnFjDRRUZFZ3HjVxQ0Ld8ifYIQ4hlwOMTPANuYVCcaMqNotLzqn
 uP8qsTYTX08NTkMDdbKwSDFAODWDjTfF4kMaFHWdcD5LNwM6n1/D0H7fs8dCs0QblH5NLMS3wOP
 cytJZuPG83ozvjQ8ltxlTWewM/T/EfO3xvPkPFvovEe6rbJu27vT7QyfbJIh6wQoL75VGUHX9fz
 WGCzkAspYFRn+dqOyvXzu7TCckYwcp8zgxM9zdE7MHY5TF0rFmPpAlOjLpDGi8hqO+UNc4VMv4i
 fhWvRK8uLpxUchx8DtvEpTtkKAkF1ewOlWDjmk4q2onYDYZqkbi27HqMIxR+RTEAixmr/7iiZjO
 THYvGqc+SsYK2PV5CHF0E2yE4vlGkrAYY0YPSBaKeNpyd8zoZKxgasgyChfhzsOAtPgqUZtvrud
 +OvYiqRR9xi3yydwmpO4oJiqNcHI2HjyRWoGQwr48hapEZaBTLwwyxIE58kvKofPndRoNxsjuL8
 abYu+qHXxxNiw2OriiM4ZkC88P6ve7iPodN02+uUaim2884WUm4=
X-Received: by 2002:a05:600c:3555:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4bb8881da76mr402216785e9.34.1795676839792; 
 Wed, 25 Nov 2026 23:07:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb905f1489sm365469515e9.0.2026.11.25.23.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:07:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] net: fastboot_tcp: implement the download data
 phase
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261124-upstream-fastboot_tcp_b4-v2-1-e32162bbab5f@oss.qualcomm.com>
References: <20261124-upstream-fastboot_tcp_b4-v2-1-e32162bbab5f@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 08:07:17 +0100
Message-Id: <179567683718.358187.7082427209399595494.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795676839; l=255;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=mQfG04OTL4H36R0Dk60108X3PohelkyTi0Yqlk6Gm6A=;
 b=JnZXpFh9k2tDcvyTURWCpoI/78XRVEoJUdnzm8Ezb5cQuVW+Kkgh0v6A8Gh/t9nUhOZitzqiq
 hCp4/gXUFL3CgGT8jT23fRt8psSlF58g/qH1MxixA92rgKMB0bivltS
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 16:03:39 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> net: fastboot_tcp: implement the download data phase

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
