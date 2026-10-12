Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3730ACA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFD6A40581;
	Mon, 12 Oct 2026 16:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NmbQPN2l4y4P; Mon, 12 Oct 2026 16:15:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E4CB405A4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821756;
	b=MZbBnGE6HKFBSqNTJ9YrIZslUSOiHq6cPkjvV+CKcJaMO+GLKR5TKZTou9K/wBEpRMjL
	 26LWgdiRKCoHn7Z9YNpiHEjGq6SfQqE7ICxcmP4wqHDgSetxDnZzcerHGLjpZFJIgLEFE
	 sNKyULrv1pczHHx9rp3COlE3F7g6YDrn2LqSMHWUmEa4vR6aDJX/WfWnJd/cfn8BKrXsK
	 9D2PIT+4rWtXF36lLNQYKiUYTiFvgBahqBLU4ra+eLsq58Wx7aks7vUOT1YAWkDJgHWNk
	 RKnJlojvdpor/Wx/YWRsjoaMkUkKrus8orW7wOPI9tDStQuaGrAB+wEykXCmtztNWlQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821756;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=elWiL/tbEQEMDU9fD7wZFPjd07hFyma4u5YkYr4G4j0=;
	b=AJnOcldBhY+kqbbjTAj4ZvxAPErSM5Oq/PE/m2JR8Al+rY+Xox0NgM93o0UVHA5gDr7h
	 ozXeoKcwdW3N7EahTBHDzSbOkyAeCmdJ0xPzJPysWKEhIpwjsmr4nuLtfjtumWMav9Rpp
	 QkW58P8SQxAoJYbOcZvrRiDFEC3564DGWG/wCXwcmvKadjaKiD/MKaET/PA5QWO4hL2e3
	 UKNtQIjPua3sc1ymOX/E2iXjD4jQdxTSgdbS/ZW0WK0AxMaxecbun2SiDtaYpyTRY6vgm
	 SxdqGgL6QjZHzDPP0GpzO+736oqLh7wWutAJ07IdEY2sYFWxC61lyeZJq+AzkD4pSyQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821756;
	bh=elWiL/tbEQEMDU9fD7wZFPjd07hFyma4u5YkYr4G4j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGpDMIDZz021krDqy3EUrnq6yCAVHZtAncs6AcXOK7toBNK4MX3ZcH3HmIQAUJBtZ
	 z+5eauW8aedqEQhioMEEN8HILEILId6rXbNgBRLyI2GLRvmXTD8A3e5+a+ghFiLZnA
	 NiWqu14doWDHt+pYLx0GK5g+FGVlywej3qHWV+yXlUv5xu51aKdsYfIm/gPOnLqdRx
	 V87C0Wr0JBLrgNnYdse4e9JAYS23+ynlaqWC/ztOb75IxUJ8wqVjroijh+uxBmdKDe
	 EyIp2pR6RJd6z5ouwBX6LsofYd1ApPHHK0xXBbFy2HSdgrD8zzvuaysUnSutluih0f
	 NCqOmjK/k77tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E4CB405A4;
	Mon, 12 Oct 2026 16:15:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C3B5105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4237D40210
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qmkZ1ZhbjEUi for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 23F3F40201
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a0b:5c81:1c1::37"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821753;
 b=mwsY4aPzleXGdgWRq8u13xScKArrcJe4mKyJaWbpqsAW690Dv7PiK6sYFCvgsT0dNq9G
 JlBhHsga1l2QwcxkgwfsC3yIfOAVY7sezjYvygJnM3FwpyQnZsReEaDWaqKRnxw6m9KYe
 WadxbFbYDQYO+3SRnzAppkELGWSN1LsOD+TfnJfT2w/K7qy00veA7IqKqord8vOnGbT8E
 RT5/71nKaEMpG69YsHoQqmzxAd69BwqgIEQ7YGiLYYWO2SV2e+oKOIdWg41jDcUYbyCy4
 DFRuBaiZ9lafkz/gb1gk2HGRiYTSS+9tfZ8QCIhMa+/TeAAKPXYEKjuGk8UnGpJesaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821753;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=elWiL/tbEQEMDU9fD7wZFPjd07hFyma4u5YkYr4G4j0=;
 b=CArwk5hDTGRKTEdBuEHfhQJtVjE3Vmr9HU46st4NulbN3fX+596Z1sP47M/D8MCy7idz
 KI+mhODdP/3ShGHn1/n5no9fzyBv2c84WVeOq/WE2Po9XtamtrGN+a43YsbCNvr4shdLK
 FDBxr10jH3KSUQ7cI4jeiDcvuTK+00s6s/0IRilM31Icjfvur+ToaeuXOAVQn+HDYUDHr
 GY2OTiNM/F+ajd7RntF8FNmJK6xwdMDU0KHmaixHL1NkhXcHuNWM8qn+gAz2W7z+nAHD2
 l87IbPGyuXBvDu8GbsNI58acVAXKRu1sQ8sIs4L2rrGQHaixzFe++EKcNY/32TbRjTQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=iki.fi;
 dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256
 header.s=lahtoruutu header.b=KgCiFqSL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a0b:5c81:1c1::37"
X-Greylist: delayed 498 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 12 Oct 2026 16:15:53 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256
 header.s=lahtoruutu header.b=KgCiFqSL
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0b:5c81:1c1::37;
 helo=lahtoruutu.iki.fi; envelope-from=marko.makela@iki.fi; receiver=<UNKNOWN> 
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23F3F40201
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:52 +0000 (UTC)
Received: from kehys.lan (dsl-hkibng32-54fbf3-253.dhcp.inet.fi
 [84.251.243.253])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4j3Mmr5DTyz49Q69;
 Mon, 12 Oct 2026 19:07:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1791821245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elWiL/tbEQEMDU9fD7wZFPjd07hFyma4u5YkYr4G4j0=;
 b=KgCiFqSLmM+d+8veHtWniMrIE6mr3lmmvRYEhVqbs95X9aFIi0mTPEi0J25d7JDJ5hteSl
 JyH1Sn7WI91hB62mVZk49gMDyk4Xk38t3BHzhwuUKY4T3dLTvotRNtvZ91Bd/aI1X5Nqws
 Y3Bz1moyKPVJv1tAGKTVi0k6Kt45iPQneooY4WiucR70wzrIzVtCCWfF3nMpRbUXvAe+Zt
 lVAmWWI30cgv+FAfMUN49mw6yLNlsFIdzIQ5pulej4HT/eFjiQWmPHGtpWfXUbNJ6FMyWI
 hqWM+/UnT8fzzfrXTm33qxCL5yD1HbjKDliVJWPbLBjriauEieRuq+P5JkE5Nw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1791821245;
 b=MTjTFEnY9eK/liyQ1VNua29HmHhbunFB1b+jORimPp/v2UfLT24UIjvz4wAD3xCx+Jo5un
 O4j/+25llvwq8NCI0ZJL0y6zB5TzQ6G11Fwh+kU7ArONhT53fGvTYLSbssNb1anZ/2HSub
 s2Us1wcLiiToD7zvBCo9njqDyIclfSS7uymPTWPqkNh8ouUC/aogRN3cI3R5ZuXquLC2uz
 FFDgra5CkVOEmZTd9Vh/2DgvFVdvZmnU97tp5S2Qg8vOwWeKr11l0PaGDBpeWnz063aAdQ
 4d4dvJi8d9JpOkOqImxWtRtW83xFpX7BDpkIvhkqIKA8IG7nNLk3LBq8US7SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1791821245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elWiL/tbEQEMDU9fD7wZFPjd07hFyma4u5YkYr4G4j0=;
 b=s8gb83ircxkZY0gr3AJs96rvVG+0dNj7uatdMtkgvlQs9dSH8RUlQfea2oKsOrKe5cLG51
 4vmiLUhJAHVjB1W3M+sINVMmOoppq5LFXQYdBxyZ8onElPZ5JaqzhPyfnACrjsnRfMz9JW
 cXwOtoqEDWhNcUpTfsVuaGkJ8iIc8kcb94ouIU5iX7F9/Fc46H+sEaaDqHSirQy0B1u+zS
 358J/7K2Lt/RkX5nPF9tMi62eFtf+lXVxBSN9il/kpaQfOgoqXsN9ZY49DSsvYO2LTQBzA
 yJBC5jRnzXJrs8jToeV6B5t/iotobJENdf9fQ7sZUiEKQbOhqCln0s5YeFVDLA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Mon, 12 Oct 2026 19:07:23 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: jonny.green@keytechinc.com, raymondmaoca@gmail.com, trini@konsulko.com,
 simon.glass@canonical.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v10 00/15] add software ecdsa support
Message-ID: <as0Fuwvqy25b7uOF@kehys.lan>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
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

Hi Tom, Raymond, all,

Fri, Sep 04, 2026 at 10:37:04AM +0200, Philippe Reynes wrote:
>This series adds the support of ecdsa with software
>using mbedtls. So boards without ecdsa hardware may
>also use signature with ecdsa.

As far as I understand, each commit in the patch series v9 was reviewed 
by Raymond, in the same week when this series v10 was posted. Only some 
some minor formatting issue was addressed.

I wonder when we can expect this patch series to be applied to U-boot.

With best regards,

	Marko Mäkelä
