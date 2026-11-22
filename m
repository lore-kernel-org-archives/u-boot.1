Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B5606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o2ktInKt;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=pnrwl/mO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A0E6605E3;
	Sun, 22 Nov 2026 19:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HC2A6oMOiWkr; Sun, 22 Nov 2026 19:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BEA8460607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795377196;
	b=OrKwIueMbKF3pgscbRZMBxzoxJGw38eG4pXIgbajnegAWQ3e8VUPEjmZAWiu66Y/YFxl
	 PO5N1055yty/easQRp5QpoBD2iX7qzXjPWFCaL5+XZNIWfjGSmNTmfNmeXC7EpIskOEMF
	 KB+BjmEHcEG9x+7Nm8vJhZ8gHmMZfVu7HSGA2URvQTa6O6LQQaYGQl8Kfk8Z0+3N8g55A
	 5s+Hduy2VvZx85ezkCOICHqeBY/mY7ga+konWsUbCletUWZgaYAGo9StPpNpGPyrBBSmw
	 iRV+5dRufj4K/6G9Y0hLXKEigluWaaNcexVnUJVXfQFgonfC/NLaJJBUjC4inxZAq+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795377196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SiFSbS8ZNWZuvHW+Hn8FLHdJJ4MjbPM+NVD5OIRsTIQ=;
	b=iTVMT/4kMVyiWhP4PZxxp78iQ0A6UoFiB/761c6u6uVk3JuyKcGetc7LZ4iFSHreT7E1
	 SwRol4gA2pTOr1KL469zLym9qTZY22RWUQoBisRuAOIbD4uGe6Veu/Vq+gE4bvtCNpEV5
	 A1EllQU+cOfI4QyXxFli/v/F1QeFZ5XiHtA9+/GYosCxoY1hKEEeI4MimB2iY4AODJpvu
	 wTyqobX8frHI3UKSpx2UKRY/jd8XRcG/9wcFcVo7uIaLgtbTOI+/7tKx+l33sCe3iN+i+
	 bPGcM52KKi/tAta/a4RyATvI+lA8/9xfgV8rFQHMRhFAFOOMPTfkJAsuPSz2N/uNzyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795377196;
	bh=SiFSbS8ZNWZuvHW+Hn8FLHdJJ4MjbPM+NVD5OIRsTIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2ktInKtgblreFtaFrFwK8ULmXckTYqITJKzgsdDiIaoHtKa+FflRZ6C+rvuMKvSS
	 paQGAely3wvEVcIDwAhG0UggQVUuvG8pKkuNrZvu7agPtGgHbdohpZy5CvV5IuqE6h
	 EYR/ucinBe90ZfmDgBCmrt7zjfSPef6WuuqYOLm8AT2ZyKJgZfxfSVNnzcwCZQJJve
	 cXAruM0dlz+ZJTJt1wWGku6fPRjeN9yU1b6rZyWafZuld3kQ6Ax10XTt4rKmQ/NMHb
	 sf1i80Cxf2ARdjM6TUOvEeuYB3DqHiqtKZtPjDHHmna98OE52fSCfvPlIfIW4D4nNj
	 MpqI6o0V4y8Jw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEA8460607;
	Sun, 22 Nov 2026 19:53:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F58A310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 19:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37D81400C7
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 19:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N41lYNCEuXic for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 19:53:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B6374008B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=pnrwl/mO
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B6374008B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 19:53:10 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3CDA22711A;
 Sun, 22 Nov 2026 20:53:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795377186;
 bh=SiFSbS8ZNWZuvHW+Hn8FLHdJJ4MjbPM+NVD5OIRsTIQ=; h=From:To:Subject;
 b=pnrwl/mOlKOZb9I8hbYMGvYfamLlZq1kJHxq+i4FeXP4iHc+EHskJfdoxUnNv9hQ2
 kHRhvoW0J7EnGuFxjRQRJBzECx60yPSX+snl7ZYSeXcYE8oK4FCefSXmMpBmXPMV+t
 Nc8zsPjE3ZtHcRVIaRkhjaVK08nHOurAV/ip5U5xHr+WwkpcIlaGiTqJPhAiDyBWT/
 8hDDAj/rLwJeuWLUoX1Yn1R4fh/9BhK+Mt4SAvRvSkchxM4j8Cb94cTVwBbvsMgC6/
 zzxqcz+lhS2ovwquo4dvDvFdUZQO1EWRP5UntPIypmDw7we4+Sk5vHKpJGrlfjZ3Rk
 zqiq5JpDP/+WA==
Date: Sun, 22 Nov 2026 20:53:02 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [REGRESSION] [PATCH v9 1/9] fdtdec: match an alias to its stem
 only when the number follows it
Message-ID: <20261122195302.GA432275@francesco-nb>
References: <20261023111559.4081795-1-mehmet.fide@gmail.com>
 <20261023111559.4081795-2-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023111559.4081795-2-mehmet.fide@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Mehmet, Marek,

On Fri, Oct 23, 2026 at 01:15:51PM +0200, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> fdtdec_get_alias_seq() and fdtdec_get_alias_highest_id() compare the
> alias name with the stem by strncmp() over the length of the stem, so
> every alias that starts with the stem counts. On a Colibri VF50 the
> aliases usbphy0 and usbphy1 matched the "usb" stem, the two USB
> controllers were given the sequence numbers 2 and 3, and ehci-vf
> indexed its two-entry tables with them. The live tree disagrees: there
> of_alias_scan() splits an alias into the stem and the number and
> of_alias_get_id() compares the stem exactly.
> 
> Match an alias only when the stem is followed by its number, as the
> live tree does. A test covers both lookups with the sandbox aliases,
> where "test" is a prefix of testbus3 and of the testfdt aliases.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

This commit seems (74b14db48a8e in main) to break USB on all i.MX6Q/DL/UL/ULL
boards without CONFIG_PHY, USB gadget included, so fastboot and SDP from
U-Boot do not work anymore. We noticed it because uuu recovery stopped
working on Apalis iMX6, Colibri iMX6 and Colibri iMX6ULL, while Colibri
iMX7 with the same U-Boot is fine.

ehci-mx6 takes the port number from the alias of the USB PHY node, but
looks it up with the "usb" stem:

	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
				   phy_off, &devnump);

The only aliases pointing to the PHY nodes are usbphy0/usbphy1, so this
worked only thanks to the prefix match you removed. Now it returns
-ENOENT and the EHCI probe fails.

Following patch diff is compile-tested only. And the analysis is from
claude, so take it with the appropriate caution.

Francesco

-- >8 --
 drivers/usb/host/ehci-mx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612f..93b0d75633f6 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -609,8 +609,7 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 #if defined(CONFIG_MX6)
 	int anatop_off, ret, devnump;

-	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
-				   phy_off, &devnump);
+	ret = fdtdec_get_alias_seq(blob, "usbphy", phy_off, &devnump);
 	if (ret < 0)
 		return ret;
 	priv->portnr = devnump;

