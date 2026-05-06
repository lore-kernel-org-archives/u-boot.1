Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E645CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 08:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85AD58484F;
	Wed,  6 May 2026 10:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgexIIw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D03A8484F; Wed,  6 May 2026 10:51:51 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7466C8483F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 10:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488d2079582so63913445e9.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 01:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778057509; x=1778662309; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f2dB2qLeOiXn8MrlWjrALgYji0hvn02fy+4dfhqgr10=;
 b=CgexIIw9ibhPDO50oHc+l8kz2pOo+t6EvPEnDqyup5ZnxoCZLvpgqFoWoqclxeM8XV
 qB1EXd846do+vbaMD3C8H2f/Zhf5+ww2LM0m/hZUIU1oNHOULnz3OVg0J7hcO4o5DBq8
 RDmFOPg/aj6NP74nkLwlzfqTvYGyv0m0Qwz79LwWkPMIi1tO4GdbH/Sal987gAH1TPSt
 dqTfiwMbdA0MAlciY6QGZYOXhFv0fKsasc5BQlLH76bJE0OHQMNI3ZIXNuF804n+D6Qb
 50D/w0wfw8Jc3jzUXenLnwuyqUz9FMaCJ5muXf+egrPa28jluRZ5BbnsCJlGwPb7bbiP
 86jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778057509; x=1778662309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2dB2qLeOiXn8MrlWjrALgYji0hvn02fy+4dfhqgr10=;
 b=Wj+w059PTdLQLwF7oDay+vE5vU3LhOxmb8CsqYN4PLUHHl8ER8dWhjz63SKO/YMbpR
 Q4KjpLW4cQ3BQ1g8gcuKrSnyqKckjUTH1GiP5e8MPegLdWMF6/fK1U3p0qcCim05UtNm
 38ZyyMlMrQzLmDVNOuDEMUXJcqBO393eODSEu4YzEW1VTwMVvpCBu/Dg/O7DnPJ1E4Oj
 NKv/jWolSzgw0qlxW+5aIUnOcgxxvaXX8B/6BBDDVectqZiRtGa39hwFbCMw04UnC+J9
 gjL584WQf5WR93e28VqgQJC1sgWlip30n5j3jGmKvkoOm4DMue0ly4DZNapTIv6kPFjb
 RRpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cS0blYGBc8YrwuoUmTQRgYIKJY1VoSl702dhhXTUBfMseccc1siK5+clXJ95hMotcHx3sBRk=@lists.denx.de
X-Gm-Message-State: AOJu0YxlZjHQD4UhR2TvXRtZvR/rP/6qprnj3XGORwj7A+yhofkCi1cp
 ygzWaQ62pfJSW3//FDW18CUptlhlApDc33NNNlb4wBPOKNNes2xylQA8
X-Gm-Gg: AeBDietIi99BceglisIcGMQI+LuolZ3NvHZwSsYqEFsOXEpSM2fQ7+Vf5qenuDmTnuQ
 AKOlJvx/5Lb6gz+v4Y1reKjidOoJAmFSMGvQxbW3WgrAc8EwaDV1lDsQisegQOggIOi7brr2EfV
 w8Dy4CxLAPWsEvDJP89kiWCxMI0cFgDFhBxf9FW8To63jwi2TVxXHdYIGQnNxaB4ENj2AC1OmQi
 9NyhuB1anP7nnfZcyuYbRRVNJOsbo50f5aZ8r437e/WB3nYaSfMPslQ9GlP/xUsLPLlqS8Kos7A
 sdmhh6NK2ifDgv95cI9K3RYSoy4N81avR6mkoxNIRrk4VFgq3XMclZYm6neQvGul5Cl09ZoTSIp
 tyuQZMn3PauiizM0NMW6OHkRJD7lR/vJNyhk7sm/qwNDA6lglRYU6Hxx+2ufpVNh6msGKqYi2VI
 YgvVRvKTYbXzqlxRdWZqAWx7JvcDlEPSBtKgJ+zydLpiUCq4kp+VypxSWwk1lF/B0jR8uZKP0Db
 6H7eTkjx8ijexuHpLHmRw3Soe8rvbPHMhwabA==
X-Received: by 2002:a05:600c:4512:b0:489:284:44ab with SMTP id
 5b1f17b1804b1-48e51e1deedmr41368475e9.12.1778057508580; 
 Wed, 06 May 2026 01:51:48 -0700 (PDT)
Received: from ernest.hoecke-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530c5dfcsm11658025e9.14.2026.05.06.01.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 01:51:48 -0700 (PDT)
Date: Wed, 6 May 2026 10:51:46 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Sparsh Kumar <sparsh-kumar@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, vigneshr@ti.com, 
 praneeth@ti.com, bb@ti.com, afd@ti.com, n-francis@ti.com, vishalm@ti.com, 
 sebin.francis@ti.com, d-gole@ti.com, a-kaur@ti.com
Subject: Re: [EXTERNAL] Re: [PATCH V2 0/9] board: k3: Sync rm-cfg with TIFS
 v11.02.09 firmware
Message-ID: <avxsp5t6p5vchnarqtmla4rm3y2otv2zazjx52nzgshpwsy4u5@zzoo74zbwuuh>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
 <20260225151047.GJ1593142@bill-the-cat>
 <e6d88daa-c00c-418b-a8df-3714c7254002@ti.com>
 <vjlrb25moymvlg6tfofolyc4ybgfju3yglefe5olcjk2qphz2l@5d6e4knya7re>
 <51d0ceea-f139-4ed4-b245-0eb31a246d90@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51d0ceea-f139-4ed4-b245-0eb31a246d90@ti.com>
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

On Wed, May 06, 2026 at 12:58:10PM +0530, Sparsh Kumar wrote:
> Hi Ernest,
> 
> Apologies for the delayed response.
> 
> The M4 core that runs TIFS has far less memory available (176KB) than the
> WKUP/DM R5 core. To keep the memory footprint as small as possible we trim
> the full RM board configuration down to only the entries that TIFS needs and
> store the result in `tifs‑rm‑cfg.yaml`.
> 
> A couple of important points:
> 
> 1. Both `rm‑cfg.yaml` and `tifs‑rm‑cfg.yaml` are generated automatically.
>    We use the K3 Resource Configuration Tool (formerly the K3 Resource
> Partitioning Tool) to generate the files from the SysConfig file and then
> copy the generated YAML files into U‑Boot. No manual editing is involved.
> 
> 2. By using a smaller board‑config file we free up RAM on the M4, preserving
> space for future features or extensions.
> 
> 3. Secure‑boot relevance - The `tifs‑rm‑cfg.yaml` does not play any direct
> role in the secure‑boot process; it is simply a streamlined copy of
> `rm‑cfg.yaml` that contains only the TIFS‑specific resources.
> 
> Please let me know if any part of this explanation is unclear or if you need
> more detail on a specific step. Happy to elaborate!
> 
> -- 
> Best Regards,
> Sparsh

Hi Sparsh,

Thanks a lot for the extra explanation here, this clears up our
questions!

Kind regards,
Ernest

