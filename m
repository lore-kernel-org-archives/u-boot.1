Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B0C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEA4831BB;
	Tue,  8 Apr 2025 10:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744102362;
	bh=hSNxD+5rmoeNVHXRMYThmN93CbVHhhNtGId1hpkO5RE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=zOaTVnReiQKoFYq6ZVL3C4Dkt/ho+mDDpIhG1pZhB4/IoTjtLRQgW0PUbqEIaGWWb
	 EAqMSc9Y9o5pIjbNFnSej5zAX20MOE8eE6/CAbC0T9We6+R9nCnEyIcQuU25ERjUBc
	 REYjv8tb03g/f4DL6ftfoqkDbwXfyjfcDRm7guoWTazoDAm4QtlHoh2gORrGzMi+j+
	 XC0D0enPFIUY57YsVjBEE9opVRAI1vb9AKGz52qxYUvMfiF7jc7jMk0eJR3xWCfGx3
	 6WTRrmkdq1cmP0HBFQWfcq6dQqQNyW1L1q2ICFuBVMqb/HXndC5QtkQ6Mc/K0dvXVL
	 2ChDTkAJDn1rg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7257B831BE; Tue,  8 Apr 2025 10:52:41 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2822882FAA
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="h9VtE2Lr"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 803A1102EBA4E; 
 Tue,  8 Apr 2025 10:52:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744102358;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=hSNxD+5rmoeNVHXRMYThmN93CbVHhhNtGId1hpkO5RE=;
 b=h9VtE2LrXMdbcvetUqWNzJzxx8fEQkJ3UYBhKHNd6RPtp2Ey5Me17hWNo5ROuOm2v66NBx
 3lycaUuE4fWRqx6V8HhZ9mt3/x9yOCNmpsFUjmv7k74PjTo/tnzbCFpEqQ+npUVFJuGNHB
 LAU8Pph7prMXvAi4wkTfMJq5M9JCoo+mV+k5AkuFeF2Hg4ArT+L/+yYc0PfY28Jm/oqZAd
 4kG1K5ne1v00jUbH9hfOFzXr9ttspKRY/DPxqrvzdmoAbQjbAny58baZ3KKim8s5wOf28a
 FkpcxMfuuWmZwCJeQo/synx9n1D5eQIwQorECCx/nPcL5IVQHftkyOVl64B3zQ==
Message-ID: <dc23a9c4-b2f6-8ba4-48ec-326b00e1e85f@denx.de>
Date: Tue, 8 Apr 2025 10:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Oskar Nilsson <onilsson@rums.se>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-ubi master

The following changes since commit 34820924edbc4ec7803eb89d9852f4b870fa760a:

   Prepare v2025.04 (2025-04-07 15:57:55 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-for-2025.07-rc1

for you to fetch changes up to 3d1cc840a060cb2a00b4af0c70fc29e8c3cadf90:

   ubi: fix bug creating partitions for non-existent volumes (2025-04-08 06:52:24 +0200)

----------------------------------------------------------------
ubi fixes for v2025.07-rc1

- ubi: fix bug creating partitions for non-existent volumes
   from Oskar Nilsson

----------------------------------------------------------------
Oskar Nilsson (1):
       ubi: fix bug creating partitions for non-existent volumes

  drivers/mtd/ubi/part.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Azure build is fine:

https://dev.azure.com/hs0298/hs/_build/results?buildId=173&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
