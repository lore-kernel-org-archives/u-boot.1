Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD98ACCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AFEC40986;
	Fri, 16 Oct 2026 14:47:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DogK_9WJIEOE; Fri, 16 Oct 2026 14:47:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DD058409FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792162040;
	b=Z9xtQcu/SZZyIFdWr7Pn2//f0xpKY9hd6hcWCOYRYfBiNxJ6J5/CNhJLr9/DyW2kekLG
	 3grQUebtl9+hs71d+ewJKTpZmJB+uU8Ws4NGh+KLUHOyn9B1lhSX3QwTXvIv10L0M67tk
	 ZvufGpA4QO6+xOtOmGZXt/52i684MP4OUG5ZTd2vRwqAOkxYBXXFBBMfZ0BrTrfeZHGmB
	 ZG6oxXxcR38iDAP8UgVju8UV1XKRgGMBpuPS6bPKSyDkwK70NAl2gfv8dfJC+Ns2WGjA4
	 RXsmH45pjCTs0RNrofzBPtOe+kPpRD+c0PNoltP4zpl7WB6AhvOwjivC53LsXWF7Z1g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792162040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
	b=iBLAb/rhBnN/Y/BsbxDjtcDEDRseysYpZMzrGJcOe1joYB4cE18oz5pNmB3EAHjVnC5Q
	 xtAACjeE/w370OZAuL0BkQRx6epk6IXKMBML8WShgLrNNVAZzvc0ZcFmBcq2cymWx56w2
	 i3G2tnO/hT4nX4e5GV5k6tapjFA+GtSTM23ByprkCxYbGYSt5AL68wVVMlJHKVVCLCtT8
	 ZjVgRtoGBhYUNONNJ2ZipdQN66+hn4Xe6GPy92GqGSo7bI9eQYrLqvtqHO1gZ2F4Jok4B
	 9GgsrPWpXEGg6vnnpMf04szMK+yDud7cfqheB/zOrpXRqnwcFCi+j/tk6ltBkiwHB0w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792162040;
	bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ls2X5jdgMCnfoa4ccI8uqXlm4ZsKlcXFsygHs1VrmctHRryZoEnOC5G3PmtPA46G/
	 8Gv81M547r6dhOkxfo2rmkYa26hOtt9lFqhugPqyctk5dp5zkCxWkVIp8YB+ZMn1Ym
	 Kc6xxaf7CAjkvnyfOe8kj3zKZJcrW1LaUlgj8o0VrtLfKr0g/xjp+TOXa4e/6llOnC
	 O5S1HxiaY3KABMdVL75q+QLI9+0dBEzjj0PfbpumzXScxl8H3sxG53eWKtOc/98OnZ
	 w3uYsV7ZcR+ARSqQIZ9fejtAcXcVwFW6JEvZsGKbhxHHXJxWnQCN25qfNiKODag2ZI
	 TT/rRLgCUXx4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD058409FB;
	Fri, 16 Oct 2026 14:47:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0869F7AD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE8108150B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaINiS_k_aYv for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:47:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D98A081323
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792162037;
 b=X9hsQw/Yp7KFwzGwpOM97tSuP7YuXYincl1LWPv20F6NYw8kfHa2UOdxEvCdgxNbGcak
 Wojcc5MHe19KwRt5Kq2Azcb/GgZ9mMYc0sZjIFyHOPCgWPrC+Kf/gcugOpCajiipJ89TI
 NmHX2Ue/JJaPyhVg2N3FJCpUNEcywTl3Vk5i5qsKpUdxtbkyVM0nVpKLuYL/GpPd3Avik
 Ptg2ZW6hJ1Y2L+uCvld0Ikw4oeZzJElqOg6bHiBeNrRZzb+zxwhsv6P/ctdTfhAEjH9Wj
 J8B2/R9iGvZqkIkqCEULWOt1tvEjvg1R8r+B0LoW6JLMLyO1jqUC9nJIzhED3rhBq8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792162037;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
 b=bsDSscqDYOlwG5MKdIOBjDXVzp8f5i6UggVOeH+nYlhBzBqqsu9edjJLAu/JbS2pClu8
 Yi5ZkIoxqFyzL0fBPsD8Ij72fINVRCaKhpevwxv1WzCCy/vcwQgQ4Xlw/0RPZs+S2QBIk
 6dv5xUqpPKj+thcjimmKRXp9UCu3AEz4GZDtg4YS0RN8zrPAdgVYR40fi7nIYILYTUjJz
 Wh1v/po2d2cHfOOUW9SsXn36qQedd5gnfA7oVe4pS4oK4/Eng2By5pnTb/dxZIt1w0/2G
 RnrBtjXqXfaHQJXnDkIyvW05SxemDdVVr80PPoArhOeo/+oKqO9LB7sN5yDZ2nZ9Inw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XljT4ILy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XljT4ILy
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D98A081323
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:15 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5bc18f54abbso32986e87.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792162034; cv=none;
 d=google.com; s=arc-20260327;
 b=SR7+Xin5KQWUVFptdbQDRe2y2Daf+osNRTGKtIDCMzhMD7f5CrbvVd5lC2+ZA1jUBu
 WLbAJy9YobCVemTZlv//n9y0GvOukCva1Ml0WEI6S1B5UWhLUmo0wOJUYEPO73HZjaSo
 eWFEK+CJ8L996DMKiWKxgf8z9PLTgdlAQKE/uM5/utRUnH+yvkD+yMANc+itCSKLEYf8
 QlOSfl3kA8c3bWf18LvtNV9CFTVffdV9Az+iUJUIgjCJtcqn2p9ppNbamtkPyU6ceozg
 BKU7WUQDkqiJEdqeqP9Ad5MayhPzHMB55uaScBtXnLJNlgAw1mrnNqQWUzfH9sUKtrCJ
 7Fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
 fh=kj/kWriqbd9eLYKu2PX/GyXx3CAGHG+0fu+tildUQDc=;
 b=n7Yldgk8WMm6ecI29LS9fBcr4/LR7PKlvG7p5EzDZaC1DfSc5PuAwTJhvQtnDzpT/d
 uLl/lct0jN5QeGduM0QUW0fwpel2V7rBeFTwfUpuXCfqiQ+hAz7CG4thEKVPIqiK5y1J
 Is1mlR6HzrczuO5pGlmO1Z/NnoJclcKJ1DkNl/bYI4iGlqkfs502atMUlqslXeUakKi4
 DL4DUYMq7sOMMl5HuCApAv32NGLP1afdTDQ5fev0bPIJ4nMHd6GBKGYDtifC0ntV63D/
 UMoOKkGY18Kr3Va860BeNo69ZbvBikCHaKWwxxsya6ZGcoD9Fr/W2M46i2tJvuHkurhJ
 4yGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792162034; x=1792766834;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
 b=XljT4ILyqANmgh2IxQnMzz9HqUJdN1rHehFPwBk+a6l8+ji0u5NvfSDkE6rgsaLfby
 ythY2NPSx4V5rGYPuJESFXybT/cfxtXylE72pObm6tbsfSe6qilTn9McsclN7opMzmJo
 hDD/dzismnfng4ETDWQFdbeTab8oCpVFPGo6HjNb5j6eNoPdtPI/DRe3CL79o2yG9swE
 R20I5ZTkovD8aayIu9VmdW+jKrIyO0NIVN8dmvOuYrfanQ23BLMmOf4Kc3DTsDB9Xhg8
 xIjy9R66e5mhmxxl8H3uhtNdC1Hnw3wYhiTrqNeEGUe3cyGCGy4irKabnf0qgxsOIPJg
 V7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792162034; x=1792766834;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bswte//9Dp9ibxjOPW/TnCbB70Z2yDMk5I50vVa5PPk=;
 b=Q3AZiAkr++8CH5iMzT8Qq9gpZEZ8yq/S8YpKfqB9IZFNPcX7GgoptASiW13kdTOlhy
 VZOHPBp5KNwza1cCA5GzKpq+Q/LgifrUFSTZP6RFI+bvR045FBpuSgZeshns069jQGMA
 c1+W07FRHsxLbxwpuYi16g22o60DJlFi7e5knr4T9cbbJLxHfVS2B8NWGd+ne9hPRVTo
 x656FUC2FyKTWvi1EhV1mmLDv/7sDC5/ZcTIVzz5fwWRnzTfYJ8rZ1iHOYv/CcIBIkWR
 o2ikFsGSr+FBmaTy1HS1ruvXbWi4Wtw5ZXIo52cD833AIqneWI69enHiP56yJC8hjxSO
 4PpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6HZv+Wge4mRqngr0p+v2nGHiFZmvx7QCYUShG2dqwB6Err2CeeryQ7Z29mNJU6/fQtzQIp4U=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLp8JQfxoxzZe71TpkfvJNH7o/IJWWdRrfh0Pc4Y4EXC5XHitVD
 6otuYdHotYD3Nylc/z54V1193ZxZ2W/NT2mfvKWgRd4zS+obE3863U5ktishd6GmJZgp1QmkPJU
 VxCzZG6/JUFY1q/AJf+ouSShfC9E8e/k=
X-Gm-Gg: AYBFou2DIXcY/MUtEPVA+ldk6hAQ45VPDuP8c2FwxwXzey+HmYWptIVrDnXlQDhe5m8
 K8uMWC0wibTb92eMnzHfqQOhkjF4/YzQVL5Af3anmOsSvM13TV+oD8gsZa57S5q2fmBc9SOhWqT
 b2si2Ck5++fTSoLX66/PcF09/w0REvfBlTiuAKWbB2EcONEq4iVnmwpDUf/wC4AtTSRLQ7ffHOZ
 Kn26Hyp2wWEB+WDliIVZOBpsxFGAPBGacZrVZTDXVDiYVDXDi6icrXKrldYfLkWLfmnlcm5JOh0
 e3HfoHldc2bCBycXX2rJ98pLahckyPDEDkNtGZtkwY7ODmvpioEg3pxXaGTE+loUxM4NXh06twk
 nnXcbLuNstuxeDRDaf/A5i8btqIl1SzfYDWur1c6GB6xuUTU0kosIpUw=
X-Received: by 2002:ac2:4c56:0:b0:5be:494a:f966 with SMTP id
 2adb3069b0e04-5be494afb99mr886410e87.44.1792162033391; Fri, 16 Oct 2026
 07:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
In-Reply-To: <20261015-feature-main-imx8m-ddr-reinit-v1-0-994706166ada@kontron.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 16 Oct 2026 11:47:01 -0300
X-Gm-Features: AclHuK-ffpJoCWEUwaw30XHIr3vxl-aHMJruRn8xC8UOu_LQjMlGWMto33wfLFE
Message-ID: <CAOMZO5AsT=xrbuKWDf=kA2WPiBKtE5wc9rMpPfz5ib49N16Ebw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ddr: imx: Fix repeating ddr_init() on i.MX8MM/MN/MP
To: Frieder Schrempf <frieder@fris.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, Oct 15, 2026 at 11:25=E2=80=AFAM Frieder Schrempf <frieder@fris.de>=
 wrote:

> Also tested on a Kontron SL i.MX8MM with 1GB LPDDR4 to make sure the DDR
> probing there keeps working.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Frieder Schrempf (3):
>       ddr: imx: Use the correct GPC registers for the i.MX8MP DDRMIX
>       ddr: imx: Recreate the power-on state before repeating ddr_init()
>       imx: kontron-osm-s-mx8mp: Remove DDR reinit workaround

This series does not pass CI. All imx8mq targets fail.

Try building imx8mq_evk_defconfig, for example:

drivers/ddr/imx/imx8m/ddr_init.c: In function =E2=80=98ddrmix_reset=E2=80=
=99:
drivers/ddr/imx/imx8m/ddr_init.c:424:22: error: =E2=80=98CCGR_DDR1=E2=80=99=
 undeclared
(first use in this function); did you mean =E2=80=98CCGR_HDMI=E2=80=99?
  424 |         clock_enable(CCGR_DDR1, false);
      |                      ^~~~~~~~~
      |                      CCGR_HDMI
drivers/ddr/imx/imx8m/ddr_init.c:424:22: note: each undeclared
identifier is reported only once for each function it appears in
  CC      spl/drivers/crypto/fsl/jobdesc.o
  CC      spl/drivers/core/ofnode.o
  CC      spl/lib/crc32.o
