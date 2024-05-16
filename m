Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EA1C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8D8E880DB;
	Thu, 16 May 2024 13:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715858856;
	bh=5WKDBeE0kkl6KVdsmkFQnOjhvd80u55inqyM17bfJ+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WR3thY2jFeBPtQp0gsJtbkvR8K9S/YfuoKSpRU8YEo1kJKsTpw0UMTPfI5LdB63hi
	 /W+Bz97nwLg16NqpyyTikmBR4s7dTIcQPvnRxXqnonennP0woNQ9IIFg7Sjl/0G0E3
	 80I/DoJwTW0dJNNZh4VlcQLch7zrO27VOA9kxXDNIGYmMXqVx19FM32ZiWGRbqwhsP
	 0S8iZRw769w2K+ulEopalOMOSabp8M/PRZoi5SKgveaI9tJd8E9/GIi89fpvK7f2bS
	 5GWL01ojGjvmbJbsR9yyk2vjUJ8lrN53tfe/39DYbSZAYBl7HvUpPy75a7nIaplJeW
	 uZf6DCl7nznGA==
Received: from [10.88.0.65] (dslb-088-077-007-084.088.077.pools.vodafone-ip.de
 [88.77.7.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6991D8803A;
 Thu, 16 May 2024 13:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715858855;
 bh=5WKDBeE0kkl6KVdsmkFQnOjhvd80u55inqyM17bfJ+w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=0OL3zG4GhKgdkgJHqgOEWsEy0/Mws6WqoRZRfxyAl0Xc+LKy84bhejLoskFwTFi6X
 7BLmuDWlviqB2pT0KpLbxdbWZbdQZ6daOzilHlrOIEjPzrczRmNfWh87QhFxRJKkFv
 YmvbNeIGRkEjz741oBYHx86JJr0EVoRFtxwoLqbBDcdeOJ34BgDhGdVTiaHkuyjUuo
 2n98MtzsybAFNpOYLhC+9kHwb0AHrxqzbdIdIHY2OtYja2O3iF/sR3aWl2PP0edmEw
 ZWrpnagqDIDkIjK3m7uFGKyy6IRdCGCv/5c3nN6xedCVQ+H4TXCuiM6yRlG/hprkoy
 Mt+/RzoYSXTEg==
Message-ID: <bbd514c5-3463-4aba-9287-666b3c6f2239@denx.de>
Date: Thu, 16 May 2024 13:27:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 open list <u-boot@lists.denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
 <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
 <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
 <CAJ+vNU1NJOXELwyUJ_QW4m-QTdJZwSA9R8v3-1wzJK9K8PxEZw@mail.gmail.com>
 <ac57d92f-5f75-47fe-b2d5-5f633290b030@denx.de>
 <aa29ae8a-ca23-4139-8d8b-e56ae0e6b8eb@prevas.dk>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <aa29ae8a-ca23-4139-8d8b-e56ae0e6b8eb@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Rasmus,

On 2024-05-16 11:50 am, Rasmus Villemoes wrote:
> On 16/05/2024 10.25, Claudius Heine wrote:
>> Hi Tim and Marek,
>>
>> On 2024-05-16 12:46 am, Tim Harvey wrote:
>>> On Tue, May 14, 2024 at 11:50 AM Tim Harvey <tharvey@gateworks.com>
>>> wrote:
>>>> On Sun, May 12, 2024 at 10:08 PM Marek Vasut <marex@denx.de> wrote:
>>>>> On 5/8/24 9:23 AM, Claudius Heine wrote:
>>>>>> On 2024-05-07 3:28 pm, Marek Vasut wrote:
>>>>>>> It would be good to mention the DT properties which govern the crypto
>>>>>>> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt --
>>>>>>> somewhere
>>>>>>> around this sentence.
>>>>>>
>>>>>> This is something that should be documented with the changes where
>>>>>> that
>>>>>> code was added, IMO. I only documented here what I found out and have
>>>>>> used myself, I haven't used those.
>>>>>>
>>>>>> I would be interested in reading how to best overwrite those paths and
>>>>>> the image structured from board u-boot.dtsi files myself.
>>>>>>
>>>>>> If you want to can pickup my patch and integrate it into your
>>>>>> series and
>>>>>> extend it.
>>>>>
>>>>> I'll keep it in mind for V3.
>>>
>>> Hi Marek,
>>>
>>> The documentation patch here by Claudius does resolve my issues
>>> discussed in the other thread and I can confirm symlinks work fine so
>>> I think something like the following should be added:
>>>
>>> CST_DIR=/usr/src/cst-3.3.2/
>>> ln -s $CST_DIR/crts .
>>> ln -s $CST_DIR/keys .
>>
>> `keys` and `crts` are very short and generic names, and putting them
>> into the build directory might cause issues at some point. But I would
>> not be against putting them into a sub directory (`imx-hab/{keys,crts}`?).
> 
> It is probably useful to be aware of the quality of the cst code. For
> reference, I quote get_key_file()
> 
> int32_t get_key_file(const char* cert_file, char* key_file)
> {
>      /* Algorithm to locate key file from given cert file  */
>      /* for now just assume the key to present in the      */
>      /* same folder as cert file. The crt in the name will */
>      /* will be replaced with key */
>      char * folder;
>      int32_t i = strlen(cert_file);  /**< Index into key filename,
> initialized
>                                           to filename length */
> 
>      strcpy(key_file, cert_file);
>      key_file[i] = 0;
> 
>      key_file[i-5] = 'y';
>      key_file[i-6] = 'e';
>      key_file[i-7] = 'k';
> 
>      /* Search for folder name "certs" in the file and replace it with
> "keys" */
>      /* Keys are found in "keys" folder and certs are in "certs" folder
>      */
> 
>      folder = strstr(key_file, "crts");
>      if(folder)
>      {
>          folder[0] = 'k';
>          folder[1] = 'e';
>          folder[2] = 'y';
>          folder[3] = 's';
>      }
>      return CAL_SUCCESS;
> }
> 
> Ignoring the inconsistencies in the comments, obviously there are a lot
> of implicit assumptions on file names and paths. First, the assumption
> that the filename of they key corresponding to the certificate can be
> obtained by replacing [-7:-5] by "key". Second, and much more egregious,
> is the use of strstr() on key_file searching for "crts", and just
> blindly replacing the first such with "keys", and ignoring it if not
> found. So if that string appears anywhere in the path (say, my homedir
> is /home/dcrts/ and I have the key material somewhere below that) this
> will replace the wrong occurrence (and look in /home/dkeys/ ....).
> 
> And of course it was unthinkable that this could have been written using
> the much shorter memcpy(..., "keys", 4) so that one could actually `git
> grep 'keys'` and figure out what was going on.

Exactly. I had the pleasure to read cst code a bit as well to figure out 
some issue. This is also a reason I suggested to just set the base path 
to the CST/HAB files instead of setting the individual paths to the 
keys/certs in the hope that this is a more robust way for cst to find 
its implicitly required files.

regards,
Claudius

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de
