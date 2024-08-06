Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A2C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 04:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C54E889B7;
	Tue,  6 Aug 2024 06:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722918562;
	bh=UGNybR36ZEFFFgPCJJe9GPL0yJE4E+jk0ObOr4l7Nkc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=eU2ORLdS6j7guQr9Th1shBtdg0kFN3V//SO8EPFm9qS2sbZg3p4x3o0DNqKWDdQbn
	 zPl4inCshZwxyWCPgHgq1gAXaJhdE1UDlYCjh4mh8TfkkOSOYq7nTsBVRJ1UP68gjK
	 Eoc18G036VPEneTpuYmqbYPOGEwQ5EkvxiZVymWmxUBpLcaEWYy95sA9PIcEBbaDLx
	 6s9XV9PdBXhAP6WCW71stpH1ZP8tS4I+o6699DDDEvfowduULeWfuk8wioKYiJybNb
	 /DhlZr7hFXiBaw+BZVFaRdv3AB+8xOodRFFt2CTa9vWE7Z0fuNUnYmLp66lsCMS9NR
	 E5NpHCYSDQAeQ==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 372088898E;
 Tue,  6 Aug 2024 06:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722918561;
 bh=UGNybR36ZEFFFgPCJJe9GPL0yJE4E+jk0ObOr4l7Nkc=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=el70mzF5zd9iHVwqzmOyNiX5HGVK6pBQUI5ruFHuqmPNEnocle1lQZawG85hMnTYW
 iWXbihxtqvD6vNiJqV2Ny+XRV4IrFfHC41k4BA5AgZ2jVDYNpgiodGRzIzlqMHhShE
 eEnDxQFFuifAhPvtdDf5uPjWm88zV0zAGl667uylkSP9I1uKQl/NH72TiBKvqVS+UW
 P1TDFBbbASMic3IoDpa3iyuQVsZ7Q0XW5jaWRIDbOyjlMzGUYIglQFFn3eF8DcSbjZ
 G4knYdz9PuESYW8E1zwZu3KpYtV5qx+2TnHaYri1GMsZJMaXHclbVABisFyKHbck+b
 GrAk0lfc3GLsA==
Message-ID: <40ec5639-fcc8-0e4f-a592-afadce34ad6f@denx.de>
Date: Tue, 6 Aug 2024 06:28:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Content-Language: en-US
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240805173140.84453-1-michael@amarulasolutions.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240805173140.84453-1-michael@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Michael,

On 05.08.24 19:31, Michael Trimarchi wrote:
> The inode should be freed after a reference is get to avoid
> memory leak
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>   fs/ubifs/ubifs.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

As discussed, that patch looks valid to me!

It would be good to have some testers...

Looking through the code, I think there is one more place:

$ git diff
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index d8d78a2d3d..a5d141055c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2322,6 +2322,7 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
         }
  #else
         sb->s_root = NULL;
+       ubifs_iput(inode);
  #endif

         mutex_unlock(&c->umount_mutex);
$

What do you mean?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
