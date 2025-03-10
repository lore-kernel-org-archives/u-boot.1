Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53FAC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69CD81430;
	Mon, 10 Mar 2025 22:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741640912;
	bh=fN5BJDzjkgdVnYhssQNP1qPc4TQA+lxsOCMYk1VWxL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h62W9T6nrWsvL+9gsWFjwbFkejbKpu1JS2C/AfPOU+RFJVfjLLVlgxr/NlquMfQ5N
	 kvyM8N3nj8rJbSk3I/0pYVedJeJa4dSiVYbblwOkiXoY5gzMU3DD0sF8o7x2+1H5uf
	 QzlqRlhr/P0zZj+b/zmjGyvgvRzMTy94B/mB4ZvugfVCrHEvw2cm+gXvFoNaMusnm6
	 7eIIL29p7hMST8m5ncf+LmHiLGlXaaVYt/YH8wiaeKAdNOjreyA3ol3/UC5cUljA+1
	 uumaqkiPZGODUxJhgVGa55K8iAuwJZxdPRwBlRU6/fSejmBAENcRvpyv5pMYxHTsvK
	 6OC2hGbpIqeug==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D91811C1; Mon, 10 Mar 2025 22:08:31 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBA6807D9
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VPtGt9by"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EC951102A4CBD; Mon, 10 Mar 2025 22:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741640909; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fN5BJDzjkgdVnYhssQNP1qPc4TQA+lxsOCMYk1VWxL8=;
 b=VPtGt9byUNXWWRFn3cG+t5r2zYf1ohrKEh0sOJjyWODYdKRG/PozCi8+ks7iv6Si54+adD
 YrtIIeapmH7xyeyhTEt/jPYGhIWroAOaM7IURzPptHo+7F60K5KmRimJS0ZRSPkh7K+85M
 8kDsPo7821slkgtW+0uCtGegzxjUhTPZ1kByHwMxdtP7atlmOzco0YxHkcddXGr70iJKla
 p3+67hxy6jB992fOLAJL1ilZyYpW/IbjT/WH4/Z+lvjs3xXI+ZPqxZ+uzAwakC6HmpZQEp
 wdwcdPHACwhlNTod/mnjBhaDE6nkCIQRy8jW4kVt498vc9QM0hMVp4GNetAU2Q==
Message-ID: <6d68d2f0-c969-43f1-86c6-1ccbf039291a@denx.de>
Date: Mon, 10 Mar 2025 21:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] test_fs: Add exfat tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-13-marex@denx.de>
 <20250310153055.GI2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310153055.GI2640854@bill-the-cat>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/10/25 4:30 PM, Tom Rini wrote:
> On Sat, Mar 08, 2025 at 09:12:16PM +0100, Marek Vasut wrote:
>> Add tests for the exfat filesystem. These tests are largely an
>> extension of the FS_GENERIC tests with the following notable
>> exceptions.
>>
>> The filesystem image for exfat tests is generated using combination
>> of exfatutils mkfs.exfat and python fattools. The fattols are capable
> 
> Did you mean "exfatprogs" and not "exfatutils" ? But we need to update
> tools/docker/Dockerfile to list the tool there.

It seems the CI container already has the tools in it ?

Where do I update the docker container, is that tools/docker/Dockerfile ?

>> of generating exfat filesystem images too, but this is not used, the
> 
> Presumably because "fattools mkfat" seems to have further external
> dependencies and so would be more of a pain to use.

I don't think it does, but I think we should stick to tools which will 
be in production systems as much as possible, and that is mkfs.exfat 
from exfatprogs . The fattools is only used here because mkfs.exfat 
cannot create an image from list of files.

[...]

>>   test/py/requirements.txt          |  1 +
>>   test/py/tests/fs_helper.py        |  8 ++++++--
>>   test/py/tests/test_fs/conftest.py | 20 +++++++++++---------
>>   test/py/tests/test_fs/test_ext.py | 20 ++++++++++++++------
>>   4 files changed, 32 insertions(+), 17 deletions(-)
> 
> We also need to update test/py/tests/test_fs/fstest_helpers.py to know
> to call fsck.exfat.

Fixed in V2, thanks.

> [snip]
>> @@ -64,6 +66,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
>>                   check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
>>           elif fs_lnxtype == 'vfat' and src_dir:
>>               check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=True)
>> +        elif fs_lnxtype == 'exfat' and src_dir:
>> +            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
>>           return fs_img
>>       except CalledProcessError:
>>           call(f'rm -f {fs_img}', shell=True)
> 
> A cleanup to use fattools in both cases would be nice, as a follow-up.
See above, I am not convinced we should go for fattools all across the 
board. Do you think we should ?
