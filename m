Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490F3FD8FD8
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF5783F4C;
	Thu, 26 Feb 2026 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bOknMPHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41AE83F2E; Thu, 26 Feb 2026 17:30:13 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B73B83EEF
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso10054365e9.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772123411; x=1772728211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tfCLAcXLh+N4orCnxchXHnrOpYCGre40AmHi45Xj04Y=;
 b=bOknMPHdd4+x0wIAAjyO8wHKPvsg8BGAEsSudjA3I68XpY8n7igWv8o+fotlKQUYd/
 ouaipBeGGicpYNrGuhCKzxSiCn3A1U2CQiNcgE7ycn5QhcmpgScdPM/1LD4vmf2s76e5
 4Ue5Add85WtgM01LQlgujnBE56Z3WAxNpb9uoKOptBt2DwNBtZ4Lj19pVNijwft3hBT6
 9eKVEPObNuSVe2+qeB0/AlPxUlTlAdCShFk5zOvv1TJz1+4jG6H5iE6z0aC7C+ue6U6U
 ChMFJReH5MdJMvQ8fUQuoScRCJnUHcyWqugYjdQ16y7hw5WTOEKTvzy3hV0vbNAi2QgC
 3mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772123411; x=1772728211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfCLAcXLh+N4orCnxchXHnrOpYCGre40AmHi45Xj04Y=;
 b=NW5XHTcldAfkLVSGRWpevGVNajSTjO26VJoycGfm5WbOFBBY8rJgb4Dr+Bex1+M6iV
 PnpfQM8xJv4NmtgkTnvLupSvui9DGHMxRimUArCMQ3sKB/hISxv8VGB2qOkzLvLSVMNy
 /ZuQIlzshiABrLCPQDFMIthg5ix1YpmlZgmGV601lNBf0sI7qACfx5V/EMfCszc0ul1r
 xitTBCsFldNQ2fUVjF/3ODRS6pBWbsYt3veBP8kAmpMkyF1fi87FnZRsjqbubBQLR8kT
 djqB57Qbf75lD63KucCOnqCxlG2mN/rYSzDZX50zm0wHnPJsKGDlosjJDOlO2t7Sl8st
 YnHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL9CcX+/myqNxZ+izyNe1nu/H9YWszvVdi7V/9NZeHR8shyaXfqjoLmiO53XtrhjHNs78LcXM=@lists.denx.de
X-Gm-Message-State: AOJu0YweIxpSglKz5SBK/xH/aAwpbpH58o6uX6lR7GXRT9hCNQlpWoTR
 RsxmL295FMVlT0aej92SQn1COjk72lWdCAnSzPmwMByBgl22YjGTk3sE
X-Gm-Gg: ATEYQzxMct3hB2neglHVPYxVGHdDQHpmk4OSOS64wpaT7kLGkuKzojdDWpYdOj7dNCC
 zYfC7G2ivPSFsuDWE6d6bGavpR1rMxOrNNzeyBBjqOBXl3ZBLjHQxQqkoGS58Vb+6sMDRXCm9ag
 6R48BH/gGblDoHspAAelSlDO4+sA9tv0Tips3nKrwRmwKstxcBf87jBsDaCTSHogyIfoGvjZAT6
 5L3VVbMntSN5jz/MmHUAUl4T7aoUKzEmrpy3q6WW/FsCcp5j5E4OPp2ADBo3jgEb1GnUyHLxjkH
 1zZbCVvkbOYw9LorfmYAjTFCA/5sRsZcIa1DvvWery0LRnvjf2v0Fx9OQQEHCC+oFS7n5xA79IM
 UDnL2CDA3JFTnvCjj4DTaijrL3rHJ4NU3zCHO/Blv382eEl4l7mVtJtTHx8yH/CUTelzYP4+8i0
 E5fr6EPqQm7yQ9ilaWDgPehNzIUw==
X-Received: by 2002:a05:600c:8b68:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-483c3df9886mr42095635e9.34.1772123410683; 
 Thu, 26 Feb 2026 08:30:10 -0800 (PST)
Received: from eichest-laptop ([178.197.206.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b7713csm45867605e9.11.2026.02.26.08.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:30:10 -0800 (PST)
Date: Thu, 26 Feb 2026 17:30:06 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <aaB1DifzODCVv4SU@eichest-laptop>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
 <20260226142345.GB1593142@bill-the-cat>
 <20260226160901.GA29510@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226160901.GA29510@francesco-nb>
X-Mailman-Approved-At: Thu, 26 Feb 2026 17:51:10 +0100
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

Hi Francesco and Tom,

On Thu, Feb 26, 2026 at 05:11:49PM +0100, Francesco Dolcini wrote:
> +Emanuele
> 
> Hello Tom,
> 
> On Thu, Feb 26, 2026 at 08:23:45AM -0600, Tom Rini wrote:
> > On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> > > Hello Tom,
> > > 
> > > On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > The get_ram_size() function fails to restore the original RAM data when
> > > > the data cache is enabled. This issue was observed on an AM625 R5 SPL
> > > > with 512MB of RAM and is a regression that became visible with
> > > > commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> > > > location and Fixup DDR size when ECC is enabled").
> > > > 
> > > > Observed boot failure messages:
> > > >   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > > >   Authentication passed
> > > >   Starting ATF on ARM64 core...
> > > > 
> > > > The system then hangs. This indicates that without a data cache flush,
> > > > data in the cache is not coherent with RAM, preventing the system from
> > > > booting. This was verified by printing the content of this address when
> > > > the issue occurs.
> > > > 
> > > > Add a data cache flush after each restore operation to resolve this
> > > > issue.
> > > > 
> > > > Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> > > > Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > Tom, can we merge this?
> > > This is the last bit to solve the regression reported here,
> > > https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/
> > 
> > I wasn't happy with this at the time, and Stefan's last email in the
> > thread left me with the impression more investigation was needed and
> > likely something else was the root cause.
> 
> I believe that this patch is needed.
> 
> On AM62 what is happening is the following.
> 
> We have a cortex-R5 that is the first core booting (there is also a
> cortex-m4, but it's not relevant for this discussion).
> 
> It runs from internal memory and it configures the DDR ram
> 
> We load to DDR memory various pieces of firmware (TFA, U-Boot for the
> cortex A53, ...)
> 
> We do execute get_ram_size(), that read/write the memory, and it is
> supposed to restore it back the original content
> 
> However when we have the cache enabled, we might miss to write back the
> original memory content, where the other pieces of firmware are.
> 
> And after that we start the cortex A53, running in DDR, and there the
> memory content might not be correct, because there is no cache coherency
> between the cortex-A and the cortex-R. And because of that we have
> crashes.
> 
> Stefan: any comment here? Can you help?

I think what you wrote summarises the issue well. If I recall correctly,
I "fixed" the issue last time by simply calling get_ram_size() once
before enabling the cache. This was in commit 4164289db882e. The SPL
then informs U-Boot of the memory size via fdt fixup. However, something
has probably changed now (possibly in the R5 SPL), meaning the cache is
enabled earlier, so the cache is enabled again when get_ram_size() is
called.

For the AMP use case, either "get_ram_size" should not be called once
the cache is enabled, or a similar patch to the one I proposed is
required.

Regards,
Stefan
