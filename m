Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F1FCA5FFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 05:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC7F0605E1;
	Tue,  6 Oct 2026 05:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stSDBXJOGDG6; Tue,  6 Oct 2026 05:46:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2DA4B605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791265567;
	b=D0RsM3yKBSQGdvBSZANSgLQr1ItWynb+uzlNEHwNgOkWGx9qoyRPQ1dV9pErhJKf64Kf
	 Eq41lDFlNdhpgX6fSKj8RXYkM4TcphbCEu1REWWUQ+DIdsBfKhVkOh8jpEU/l9bDkfdBX
	 ckSYmaS6lnenHFUwx9s+0q3MF3ZMya71IoQg2T1WwNo4dMyeTYeDMRLeIUsLYaMv03JrU
	 xq26EA4HZmDhDdA+B4C1o4W6wn/Q8q05R4kAkWF9829aem/T2DoYm2/22mttcJV+Mc+Q7
	 l0FOEXvaF8eaKjXfjIfTrKy1TkoLyOMVouz+F2gwXy9A7hVTNmrfBYtr7F3GGf8ltrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791265567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n8Wb7DaQSLVnxaWSZ3RvwQDpID0bXM7cyqQz4e3QNX0=;
	b=pnvg34taZd/MVKzie3nvV54VHjZhnU4/cNMudT9YiaX/T8A1Mh5FU/4ndAPP23eXX0xq
	 WeBOH8oouIcspTIkeu7f6tVDha+6UZvQdSQGNWSeQ8AUSfSVLhiClQwXEzSueCRWd1Aw/
	 ipWecAV6/WqlxkIrRTruekbP6HLAFEhKlVYGugvBNwLj9a+IDfUw3lEaXZF32KGz+OhlZ
	 M4lcBC0uVaJ1IJuczdHOKk+MZ1hbGM7tCeBPVXYrRjRVoeg9r8H/VyeTtdJ0R2xsAkxPd
	 qTSeZVxyz01BIBLAa6KOUUhIdPFQTYdcgrY3Y6I8z9ceSwUfR+vhJEejB0jQWTgnhug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791265567;
	bh=n8Wb7DaQSLVnxaWSZ3RvwQDpID0bXM7cyqQz4e3QNX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2+V82ZdDX1M3eCj+vPoOb072tB4S110uNvxm+oC3qNzJf/GClsIeX1zebMXPS+Wt
	 TYPsUG/mB5zrHf/WnV8j/YRWHWDFDgoUXskJxh1n258rDIp+sfspb8b8mrbLhXDF6s
	 ZhlTDUUJgP4rZOrELsB8RKX//sWzEuOBmfj3AMUZbAKJz6WcuQIxKLvUWSQ6NJFY/b
	 WiVe3iAfKoBi1ec1jqVDjerYGO8lMstdYYS66OvPPS7fMGhZRbqKWrQglQDtAJxdOF
	 gAMvB98Tf09fQpawsvMwpPqG4n8mfVX/JHHnLbqKieEP3Zi3YCvfDs8VWT+aOodOpm
	 jUNncilbR+LeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DA4B605F9;
	Tue,  6 Oct 2026 05:46:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCEB0282
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3662400D6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Af5zu-MHn7aE for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 04:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 63D884009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791262526;
 b=ZzDq+mJzEyM9g2Af5qydBN7EaKoEe0YTIFJAiwdjkICxPdrOIJzcOkBnV/opOVFBgOB+
 28GZnHCK5UKIVomRWnxsQ4XluE1X7WVgzmZ4APfJnVmBCM8riWLRRt9/IdeLQdb/RyXtG
 WJqu9pNAIWPXrE825Y3gKrA1zOOIn8fm21jzY7dvQN/n8QtrvMSJsxzgB5YOSCPbD2ZR8
 yjMRafLekzERT7WVHBzT496FYa7cOqeKR6L+iom0gTTAJ/uXK5JtQlNbaLr43q1DaXoAz
 t7i1QfwC/YL+nPP8RA9074zJ3vlR7v2M92usA9GI8QLtfv33gQjG7LoROONCOBjTRXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791262526;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=n8Wb7DaQSLVnxaWSZ3RvwQDpID0bXM7cyqQz4e3QNX0=;
 b=qw6SKnsvVSXi7dw/Qg3yfBhWY5sXT/4Pkb5sE9mIyUi7lPuB9Coxbs5UBwEFuwWyIpvP
 j8kf8hHFrTi+LqmGe/P1CWmKa9m7jyB0rFQguOZJw99GuaaH2SkwIXhnl+NGG2BZiHYWA
 wIFnoqEPI90wwzUK6b9kdwwHBCvRolKqg+GVCLmxYsXH5x+Wgu2cpjDi1LIWqHVjqM7lf
 YHLEvO8XcEliltsh7Yk8Xj+sZi4tjAyzpjwPci2NtLgIcfQ6RQC+U8cgzMqDTZp9ZFNii
 BVYwdrt0zY/fIppE+5dndwLY80m2RSfOAd7T9fwYWFIYuU5V21yC2ijC6QAQMqmBRuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VzSQMjq+; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VzSQMjq+
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63D884009D
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:55:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 263901078E4; Tue, 06 Oct 2026 06:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791262518;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=n8Wb7DaQSLVnxaWSZ3RvwQDpID0bXM7cyqQz4e3QNX0=;
 b=VzSQMjq+m8vyZr0JHIoq9gdUUTV1H7CWzV/EsjekhlKYOVxqQcluo6TUGzhLb8/A9lBrQR
 V7wh/Rqs0yzt81qcvddQ39ufd93jPYBOfme7cqMyfXbH+x48aUQYUwZ/niHsCdzHQSkMr9
 F6BEURcgUSJC3y+GMYSADRPtORyO0aYJCBx9art2SUxrDN42901L6edZtSd3y5G9g8fCUm
 AbR9SC8PCWtuSiVRJvbRiURAg2uDjyCwGwdhV5IvVKK9DRHntaeneh7/DmiNWnmUr31qsb
 PygkcKkWVG20+sDqchaqa3WnaXhtV8RKCcBoDyuftqNGUt0Md4In99YTPtmRDQ==
Message-ID: <be955de7-fcbf-2f62-f04a-15b0bad964ee@nabladev.com>
Date: Tue, 6 Oct 2026 06:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: TOCTOU issues in AVB?
Content-Language: en-US
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
References: <e45caa4f-8ae0-4c0c-a3e9-6009b68f3400@pengutronix.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <e45caa4f-8ae0-4c0c-a3e9-6009b68f3400@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Ahmad,

please use the new list address:

<u-boot@lists.u-boot-project.org>

(added to cc). Dropped the old one <u-boot@lists.denx.de> address
from cc

Thanks!

bye,
Heiko

On 05.10.26 23:34, Ahmad Fatoum wrote:
> Hi.
> 
> I am quite ignorant about how Android Verified Boot works, but looking
> through the code in both cmd/avb.c and bootmeth_android.c, I wonder how
> this could not be susceptible to a TOCTOU attack:
> 
> - do_avb_verify_part() does avb_slot_verify() and then discards what it
> verified with avb_slot_verify_data_free()
> 
> - run_avb_verification() leaks AvbSlotVerifyData *out_data and doesn't
>    seem to use it anywhere
> 
> So it looks like an attacker able to interpose the storage device should
> be trivially able to circumvent both of these? Am I missing something?
> 
> Cheers,
> Ahmad
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
